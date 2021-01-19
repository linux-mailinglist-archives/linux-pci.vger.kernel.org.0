Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244E42FB880
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 15:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbhASMyy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 07:54:54 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21667 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389204AbhASKlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2021 05:41:11 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210119103946epoutp022766f4c1d89f8a7d92fce3b8a38b81c8~bm-lXrXE80782507825epoutp02g
        for <linux-pci@vger.kernel.org>; Tue, 19 Jan 2021 10:39:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210119103946epoutp022766f4c1d89f8a7d92fce3b8a38b81c8~bm-lXrXE80782507825epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611052786;
        bh=+7XKMc3T9eBTnjj09XrjdmMgt0rdKUYThtb6KsTWgyY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=g9KkCeMbqiuNNk4avT//iXR7bl8amRzXXldX1MCRjJUXqtU1E9kx2NkBMLC39hao7
         duYAvRaPv5N9wT1QF8vIxm+wN/AUoSODZzlwi67j2Pt0V8kuOTvZXiD/XUPkBpxidO
         CK2iYBof4vroQt2Zpf1Q9OVYHSXD0a8fao03Tjg4=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210119103946epcas5p2684a48457a7698f893fc34cb534cc22f~bm-kvQaR_0917709177epcas5p2H;
        Tue, 19 Jan 2021 10:39:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.A9.50652.2F6B6006; Tue, 19 Jan 2021 19:39:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210119095514epcas5p2f4b4f456955a8be3d05f094d38168b13~bmYsOQlMv1399313993epcas5p2L;
        Tue, 19 Jan 2021 09:55:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210119095514epsmtrp2d472b2636a457d608dbe4c93ea4b8341~bmYsNYkfH1714417144epsmtrp2U;
        Tue, 19 Jan 2021 09:55:14 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-f0-6006b6f2c65e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.F6.08745.28CA6006; Tue, 19 Jan 2021 18:55:14 +0900 (KST)
Received: from shradhat02 (unknown [107.122.8.248]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210119095512epsmtip1746f9e82069f4017eeeb552946cd0fc7~bmYqbTBGT1120911209epsmtip1k;
        Tue, 19 Jan 2021 09:55:12 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Leon Romanovsky'" <leon@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <kishon@ti.com>,
        <lorenzo.pieralisi@arm.com>, <pankaj.dubey@samsung.com>,
        <sriram.dash@samsung.com>, <niyas.ahmed@samsung.com>,
        <p.rajanbabu@samsung.com>, <l.mehra@samsung.com>,
        <hari.tv@samsung.com>
In-Reply-To: <20210113072104.GH4678@unreal>
Subject: RE: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Tue, 19 Jan 2021 15:25:10 +0530
Message-ID: <147801d6ee49$2ecd2d30$8c678790$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGwxsy/0exZ02HWY9tkJuphsuoUGQKa3YDmAkSCdsmqVAjF8A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7bCmpu6nbWwJBv8msVksacqw+DhtJZPF
        hac9bBZ3nt9gtJjyaymzxeVdc9gszs47zmbx5vcLdosnUx6xWhzdGGyxaOsXdosb69kdeDzW
        zFvD6LFgU6nHplWdbB59W1Yxehy/sZ3J4/MmuQC2KC6blNSczLLUIn27BK6MCecuMBWs46/Y
        veoAcwPjeZ4uRg4OCQETiRMvMrsYuTiEBHYzSnzp28cO4XxilJjZ+okVwvnMKHGhYwVTFyMn
        WMfnu0uZIBK7GCWmtc5mhHBeMErM2tjHDlLFJqAj8eTKH2YQW0RAU2JD7yU2kCJmgeVMEnOu
        tIGN4hTQluh+upMFxBYWiJI4P2c+WAOLgKrEuZf3wOK8ApYSZ6d/ZoKwBSVOznwCFmcWkJfY
        /nYOM8RJChI/ny5jhVjmJHFhwm5GiBpxiZdHj7BD1BzgkDi3KQ/CdpGYvvEEVFxY4tXxLVC2
        lMTnd3vZIOx8iakXnrJAAqlCYnlPHUTYXuLAlTlgYWagv9bv0ocIy0pMPbWOCWIrn0Tv7yfQ
        wOKV2DEPxlaW+PJ3DwuELSkx79hl1gmMSrOQPDYLyWOzkDwwC2HbAkaWVYySqQXFuempxaYF
        Rnmp5XrFibnFpXnpesn5uZsYwalLy2sH48MHH/QOMTJxMB5ilOBgVhLhLV3HlCDEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmcd4fBg3ghgfTEktTs1NSC1CKYLBMHp1QD0/ZE51y++ANCoacfXeUz
        itZ6+I9n9a2Lgn5ND/OM2Hyfxu1ZvOr13S8qshlvj3X9/H7d8ptvaaXMeb9oT6u07ltmovyv
        bBd2u5WLrZK+YtyRq/OVz/lSZ9gSPlGlzSm/WGy2RIr+85JwvHpeai2D0Sf1r3VtB4IPZ8z8
        u5j17ALhE/6d9QfSJCRilvKKvCmvOzFH9sC0thSBTkXZm7fZtvc5cgjKRbXuY+Ur94/7tUMm
        c/2cp23rfvwKy3iwlOkKU8MLJ+4GPdXct325P3ec+2+wJEDv9L4si9MHtOKvnV+6KPz0tyZT
        858Lfx7bLj1jA3/q1yMz7Z6+dlCr3FlmbfV7geyfQ1Lhmoy3p05+rsRSnJFoqMVcVJwIANzI
        fGPMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSnG7TGrYEg5c9LBZLmjIsPk5byWRx
        4WkPm8Wd5zcYLab8WspscXnXHDaLs/OOs1m8+f2C3eLJlEesFkc3Blss2vqF3eLGenYHHo81
        89YweizYVOqxaVUnm0ffllWMHsdvbGfy+LxJLoAtissmJTUnsyy1SN8ugStjwrkLTAXr+Ct2
        rzrA3MB4nqeLkZNDQsBE4vPdpUxdjFwcQgI7GCX+LN/DDJGQlPh8cR0ThC0ssfLfc3YQW0jg
        GaPEy//+IDabgI7Ekyt/wOpFBDQlNvReYgMZxCywmUlixdl/LBBTtzFKHPzVCTaJU0Bbovvp
        ThYQW1ggQmLljgNg3SwCqhLnXt4Di/MKWEqcnf6ZCcIWlDg58wlQnANoqp5E20ZGkDCzgLzE
        9rdzoA5VkPj5dBkrxBFOEhcm7IaqEZd4efQI+wRG4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjO
        Tc8tNiwwykst1ytOzC0uzUvXS87P3cQIjkAtrR2Me1Z90DvEyMTBeIhRgoNZSYS3dB1TghBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MK61PqBmdz7n7
        dLbi3KWSN48IKBXJcj1LqrLdpjopNU90qmDIoS+silXnjfp/sJ3IY1Ds5w3Kz2SafoFv85PX
        Nt9aRY5ws5yVYF9vvELcS6diveO+c+mtU+cLTn9+x1og1CDj5gw7l5n1UgvfRlZXunSmxRZP
        lg7m2Xb4auYtlbxzEXc81NKvFeVx5FVEyWbWh95e+ivDc92iF2tPM0/Q/Xai+sG0wPQqRol/
        EzfGPN+yryvv8t6Xtc9/aV/v7mmu27y9vvXUj9XJXpyeJ/X8TT/vPZtsHb/9pm3c3rT2/RXu
        XuzyRyxyAvS7D36ccEr2isO3uzecJuxM7p7+JJ77SHroHaYFnFLbYkubPDiUWIozEg21mIuK
        EwGcfR+sLwMAAA==
X-CMS-MailID: 20210119095514epcas5p2f4b4f456955a8be3d05f094d38168b13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c
References: <CGME20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c@epcas5p4.samsung.com>
        <1610460145-14645-1-git-send-email-shradha.t@samsung.com>
        <20210113072104.GH4678@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Subject: Re: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for -
> >get_features()
> 
> On Tue, Jan 12, 2021 at 07:32:25PM +0530, Shradha Todi wrote:
> > get_features ops of pci_epc_ops may return NULL, causing NULL pointer
> > dereference in pci_epf_test_bind function. Let us add a check for
> > pci_epc_feature pointer in pci_epf_test_bind before we access it to
> > avoid any such NULL pointer dereference and return -ENOTSUPP in case
> > pci_epc_feature is not found.
> >
> > When the patch is not applied and EPC features is not implemented in
> > the platform driver, we see the following dump due to kernel NULL
> > pointer dereference.
> >
> > [  105.135936] Call trace:
> > [  105.138363]  pci_epf_test_bind+0xf4/0x388 [  105.142354]
> > pci_epf_bind+0x3c/0x80 [  105.145817]  pci_epc_epf_link+0xa8/0xcc [
> > 105.149632]  configfs_symlink+0x1a4/0x48c [  105.153616]
> > vfs_symlink+0x104/0x184 [  105.157169]  do_symlinkat+0x80/0xd4 [
> > 105.160636]  __arm64_sys_symlinkat+0x1c/0x24 [  105.164885]
> > el0_svc_common.constprop.3+0xb8/0x170
> > [  105.169649]  el0_svc_handler+0x70/0x88 [  105.173377]
> > el0_svc+0x8/0x640 [  105.176411] Code: d2800581 b9403ab9 f9404ebb
> > 8b394f60 (f9400400) [  105.182478] ---[ end trace a438e3c5a24f9df0
> > ]---
> 
> 
> Description and call trace don't correlate with the proposed code change.
> 
> The code in pci_epf_test_bind() doesn't dereference epc_features, at least
in
> direct manner.
> 
> Thanks

Thanks for the review. Yes, you're right. The dereference does not happen in
the pci_epf_test_bind() itself, but in pci_epf_test_alloc_space() being
called within. We will update the line "causing NULL pointer dereference in
pci_epf_test_bind function. " in the commit message to "causing NULL pointer
dereference in pci_epf_test_alloc_space function. " Would that be good
enough?

