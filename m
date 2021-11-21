Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8345825F
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 07:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhKUGiR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 01:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKUGiP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Nov 2021 01:38:15 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB9C061574;
        Sat, 20 Nov 2021 22:35:09 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 77F5110305238;
        Sun, 21 Nov 2021 07:35:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4D37857D3D; Sun, 21 Nov 2021 07:35:06 +0100 (CET)
Date:   Sun, 21 Nov 2021 07:35:06 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: clear cmd_busy bit when Command Completed
 in polling mode
Message-ID: <20211121063506.GA20043@wunner.de>
References: <20211111054258.7309-1-zhangliguang@linux.alibaba.com>
 <20211119120012.GC9692@wunner.de>
 <d226b80f-8e11-dcf9-084b-af22f4803b93@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d226b80f-8e11-dcf9-084b-af22f4803b93@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 21, 2021 at 09:50:38AM +0800, luanshi wrote:
> 2021/11/19 20:00, Lukas Wunner:
> > Please open a bug on bugzilla.kernel.org and attach full output
> > of lspci -vv and dmesg.  Be sure to add the following to the
> > command line:
> >    pciehp.pciehp_debug=1 dyndbg="file pciehp* +p"
> > 
> > Once you've done that, please report the bugzilla link here
> > so that we can analyze the issue properly.

I really need you to perform the above steps in order to analyze
what's going on here.

Again, if you get such timeout messages, it's usually not caused
by a bug in the driver but by an erratum in the hardware,
i.e. the hardware neglected to signal Command Completed in response
to a Slot Control register write.

Thanks,

Lukas
