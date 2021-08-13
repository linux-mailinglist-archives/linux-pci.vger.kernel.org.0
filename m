Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB35C3EBC7B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 21:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhHMTXY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 15:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhHMTXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 15:23:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32EA3608FC;
        Fri, 13 Aug 2021 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628882576;
        bh=IwlgeTmsHnWv+9SX8uMxnltkECACWYzF6awWr2YZcrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o4dhA/iDEfMJoYZ2bq9y+AcVgg5wyrNkht08+6Sokb5kptg8j5bwvX9SmE5lLoUTh
         ZnDMjBLQ6j7rDj0Ln6vUmfsasFfH5boVhF99nKnzKOL2/Net1VIjBOEB1zpvk8m8Mx
         OCjYYYH+WEcZkiI6u2jmHs6LaAuK9KvOOXRVy4rHDv36CdDd9TAV3hI+JX01X53NwO
         LW7GPazfmHAcDUbmk5dexWqvvSJH6su5jN6Bcy8neKCTPMz994v5+NdsupUfw2r6mY
         1IGPOlgeF8kz9pBj2oeCpdpcM2EJ84ewb7R1xMPk+aJ9j0O0T51amSvu65Xisy2/MQ
         YztMO3hb56Y+g==
Date:   Fri, 13 Aug 2021 14:22:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
Message-ID: <20210813192254.GA2604116@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m31r6x1r74.fsf@t19.piap.pl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 02:09:51PM +0200, Krzysztof Hałasa wrote:
> Krzysztof, :-)
> 
> > Would it be possible to implement this particular MRRS fix as a quirk
> > only for the i.MX6 controller?  Unless this is something that we need in
> > the core, a quirk would be preferred over something that changes the PCI
> > core.
> 
> I have briefly considered it, but I think it would be *much* more
> complicated and error-prone. It also appears that there are more
> platforms which need it - the old CNS3xxx, which currently subverts the
> PCIE_BUS_PEER2PEER, the loongson, keystone, maybe all DWC PCIe.
> Multiplication of the "quirk" code doesn't really look good to me.
> 
> TBH I don't think of this as of a "quirk" - all systems have MRRS
> limits, it just happens that these ones have their limit lower than 4096
> bytes. This isn't a limitation of a particular PCIe device, this is a
> common limit of the whole system.

Do you have a reference for this?  I don't see anything in the PCIe
spec that suggests platforms must limit MRRS, and it seems that only
these ARM-related controllers have this issue.  If there *is* a
platform connection here, we'll need some way to discover it, e.g.,
an ACPI _DSM method or similar.

The only guidance in the spec about setting MRRS is that:

  - Software must set Max_Read_Request_Size of an
    isochronous-configured device with a value that does not exceed
    the Max_Payload_Size set for the device (PCIe r5.0, sec 6.3.4.1)

  - The Max_Read_Request_Size mechanism allows improved control of
    bandwidth allocation in systems where Quality of Service (QoS) is
    important for the target applications. For example, an arbitration
    scheme based on counting Requests (and not the sizes of those
    Requests) provides imprecise bandwidth allocation when some
    Requesters use much larger sizes than others. The
    Max_Read_Request_Size mechanism can be used to force more uniform
    allocation of bandwidth, by restricting the upper size of Read
    Requests (sec 7.5.3.4 implementation note)

