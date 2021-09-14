Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6661C40AF90
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhINNve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhINNve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 09:51:34 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2968AC061574;
        Tue, 14 Sep 2021 06:50:16 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D714D401; Tue, 14 Sep 2021 15:50:12 +0200 (CEST)
Date:   Tue, 14 Sep 2021 15:49:41 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 0/4] PCI/ACPI: Simplify PCIe _OSC feature negotiation
Message-ID: <YUCodXHfHmap1+la@8bytes.org>
References: <20210824122054.29481-1-joro@8bytes.org>
 <CAJZ5v0jqwgvmRrRts4Nf4ySmrp5gwmv_iJWBh3OjN54ZU+qneQ@mail.gmail.com>
 <CAJZ5v0hn5EvwjPggCeUw+kjDNjdzx3eLP2PRBGKRAyo2eYECyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hn5EvwjPggCeUw+kjDNjdzx3eLP2PRBGKRAyo2eYECyQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 06:14:38PM +0200, Rafael J. Wysocki wrote:
> Should I assume that Bjorn will be taking it?

No idea, checking git-log on the file shows mixed Signed-off-bys from
both of you. Bjorn?


	Joerg
