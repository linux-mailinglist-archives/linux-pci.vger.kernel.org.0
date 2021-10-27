Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D252C43C72D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 12:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbhJ0KCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 06:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbhJ0KCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 06:02:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F96C061235
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=IB3vKlP4on8GCe7l1kqRxw29zumVr5j1/nr3g3ShAqE=; b=TFIclONAtSjKcxHyXMw0hxIXQg
        i4qFpmRUnP0XhR8jx0r1ZLqVzGWnv9mIVHcPsi9zG9WQ2J/E0svgPJHZ/LvBhs7TAq7J9zJ43i77v
        LxpF4ceCthZEDDUxkwZeU0LU9nwkCIg7c7VZx7VXJosiC5OXg/yfwCSg/ZRN+kI9OQYOD0QpZo1Li
        /uafDQmCFr5fdEYZ455y1c71uWucC4UVAeOkl2BanY32VDjOW6CfbndZeTchTqLA3A/QlZV+Ti+j5
        P2KEFwiccphpVCEFqctNvOIpWJMxcn4NyiHbNyakPWd6p10E2q7SCSUWB1TZs0ea7MUef/E18ySzd
        JGx5THPg==;
Received: from [2a01:4c8:1042:994a:f240:791a:356:222b] (helo=[IPv6:::1])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mffgA-00HYMy-VW; Wed, 27 Oct 2021 09:57:21 +0000
Date:   Wed, 27 Oct 2021 10:57:04 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Andryuk <jandryuk@gmail.com>, josef@oderland.se
CC:     boris.ostrovsky@oracle.com, helgaas@kernel.org, jandryuk@gmail.com,
        jgross@suse.com, linux-pci@vger.kernel.org, maz@kernel.org,
        xen-devel@lists.xenproject.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_PCI/MSI=3A_Move_non-mask_?= =?US-ASCII?Q?check_back_into_low_level_accessors?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87cznqg5k8.ffs@tglx>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se> <20211025012503.33172-1-jandryuk@gmail.com> <87fssmg8k4.ffs@tglx> <87cznqg5k8.ffs@tglx>
Message-ID: <0A9FDABA-9067-4811-9B3D-DAFE5589D1A4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 27 October 2021 10:50:15 BST, Thomas Gleixner <tglx@linutronix=2Ede> wr=
ote:
>The recent rework of PCI/MSI[X] masking moved the non-mask checks from th=
e
>low level accessors into the higher level mask/unmask functions=2E
>
>This missed the fact that these accessors can be invoked from other place=
s
>as well=2E The missing checks break XEN-PV which sets pci_msi_ignore_mask=
 and
>also violates the virtual MSIX and the msi_attrib=2Emaskbit protections=
=2E

Not just PV=2E It's Xen HVM guests too=2E

I'll also give it a spin on both Xen and not-Xen=2E Thanks=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
