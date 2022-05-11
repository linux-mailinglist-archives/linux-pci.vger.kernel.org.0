Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BE6523DC4
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 21:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbiEKTnv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245684AbiEKTnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 15:43:47 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7241C06F5
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 12:43:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 31so2652929pgp.8
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r811j6eZntFkEB24jk0IhB718MeA1eoELT7MsSEeU6k=;
        b=CjxjqMXeIBtrewF2G3L87rsF3XDYqBVJ/PaoZuDza2rq6dzXN/GTDxZtIdzII7oFZc
         3rJJ0OSy2WqCtgQbO3bcXCpcAyffm9VuQ3AorcJSvGMiA6YzXJSHS0L1tP6p930tx9HR
         zU7wpif9qHuoAWdpaNVK07aj1lSDDr/pUajfq0d68yzjoWfVXVEyMfbh2QkutKnvxXpl
         44PxmTNgosRIMX6vH3NVSt5xZKGfaLAexXkVTIXk+VglKaQPt/W3FjBA8QX3bIPsbnWf
         az5ZoxAt3Oif+oP9SobIuaZbhvzjdg7rr9mbZXtQMp2f9KairrHMp0QRpt+XywylhXOe
         wN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r811j6eZntFkEB24jk0IhB718MeA1eoELT7MsSEeU6k=;
        b=w7Ya1NqXehMMPCH8FZyU8OYftfdhscbuS9oZKXgK4snlQ4zR9G99kMkGZ/bkf9PIfU
         dJporRlNw4CiM1NSoKeYZfAW+jUZ0hJK8hbrIBcRpg9rAuwEG1ePGjoZrX2B8Gqit2mC
         1TW4agU2lJOUsIDdex7DxHTxW4yAiys306/f8gLEtWZP+ScZ+X7RhSGYKDmJ/7xBvod3
         XS6s5APySYLlFL6EmZP+CAHxkWL1CYbXkpMaI6Y94sWudNalpukqWWo7T2/3Y4eW/6ZF
         o2p6lezZdiwVGbjPsN6IUBnyJ0YrlirRHSteOEHoOAJBL/pEFWTfb0qrDfgcsGEYIy37
         2J5g==
X-Gm-Message-State: AOAM530TkgIqY++3SJJF1/ttZrY1ByK0Rhor+04Hxf7fCF19SW1URMaK
        kglrb2aPFYj1+IT+JJRzwVnATnA58ZQWtjntWW4Z7A==
X-Google-Smtp-Source: ABdhPJx8P7JiKMTzNVPqJeincz7Gm59t6RnBoIGRvE01/hgTF/6TTjsC1RdVmrgjbp/iZ1las7TflyWS1FiW/DCRm0U=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr21764235pgb.74.1652298225118; Wed, 11
 May 2022 12:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de> <20220511191943.GB26623@wunner.de>
In-Reply-To: <20220511191943.GB26623@wunner.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 May 2022 12:43:34 -0700
Message-ID: <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 12:20 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, May 11, 2022 at 09:13:45PM +0200, Lukas Wunner wrote:
> > When an IDE-capable device is runtime suspended to D3hot and later
> > runtime resumed to D0, it may not preserve its internal state.
> > (The No_Soft_Reset bit in the Power Management Control/Status Register
> > tells us whether the device is capable of preserving internal state
> > over a transition to D3hot, see PCIe r6.0, sec. 7.5.2.2.)
> >
> > Likewise, when an IDE-capable device is reset (e.g. due to Downstream
> > Port Containment, AER or a bus reset initiated by user space),
> > internal state is lost and must be reconstructed by pci_restore_state().
> > That state includes the SPDM session or IDE encryption.
>
> Digging a little further, sec. 6.33.8 says that "The No_Soft_Reset bit
> must be Set", so at least IDE will always survive a D3hot transition.
>
> But the reset argument still stands:  That same section says that all
> IDE streams transition to Insecure and all keys are invalidated upon
> reset.

Right, this isn't the only problem with reset vs ongoing CXL operations...

https://lore.kernel.org/linux-cxl/164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com/
