Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13FE345D50
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 12:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCWLtj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 07:49:39 -0400
Received: from foss.arm.com ([217.140.110.172]:44702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCWLtQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 07:49:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84E081042;
        Tue, 23 Mar 2021 04:49:16 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E14E3F719;
        Tue, 23 Mar 2021 04:49:15 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:49:13 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: exynos: Check the phy_power_on() return value
Message-ID: <20210323114913.GF29286@e121166-lin.cambridge.arm.com>
References: <20210208174114.615811-1-festevam@gmail.com>
 <YDVxBzH/9ePDhy4v@rocinante>
 <20210323111010.GC29286@e121166-lin.cambridge.arm.com>
 <CAOMZO5CPseH7MFk+k24W8eXuxQsZDwzTGMCQik-_XgpVjECH7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CPseH7MFk+k24W8eXuxQsZDwzTGMCQik-_XgpVjECH7g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 23, 2021 at 08:33:31AM -0300, Fabio Estevam wrote:
> Hi Lorenzo,
> 
> On Tue, Mar 23, 2021 at 8:10 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> 
> > Fabio, what's the plan with this patch ?
> 
> I will let someone who has access to this platform handle it.

Jingoo, this requires your feedback please.

> Sorry, I have no time to address Krzystof's feedback.

Understood - since you posted the patch I asked, thank you
anyway.

Lorenzo
