Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7438C502BD9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbiDOO3N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 10:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351334AbiDOO3M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 10:29:12 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D7193C2
        for <linux-pci@vger.kernel.org>; Fri, 15 Apr 2022 07:26:44 -0700 (PDT)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2C0393F1AB
        for <linux-pci@vger.kernel.org>; Fri, 15 Apr 2022 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650032803;
        bh=e3RLpJj2erPmdXlxjGIy8hlcTxe8lmbZHUTfXz0Qd8w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pqnDApBLNjBlvriRkNuLL7OZCSPqMHXnAXCsDnlOQva/iprn86Er7vibaOMfID9I3
         SgZm1ZbjnbNxs7McyXiA4z/LPPuZyZFiw/sGx3Te5vCzRz2o6UUBSRNLalWZXr6dka
         Buf5Hj7sdSxVTmmm2Gg99758kSzqMXxbdvqbu6QlgSU5+UrBCPOl6W9q42d+/epLrR
         +VU++NeYbMqJqmBqYTuBv6isVYsmEB+s/INhRTAelAa3saAd8XbP5rQ+JHNgnDzzaC
         vBIPwAkjHaSPtr3WvERDEvVWf1vxas3YcovtGeSBhTkDIDYWeU61mWhx2WQMmhmqzm
         1sgRRqNbUJhzg==
Received: by mail-oo1-f69.google.com with SMTP id z5-20020a4a8705000000b00324936534b6so4355372ooh.9
        for <linux-pci@vger.kernel.org>; Fri, 15 Apr 2022 07:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3RLpJj2erPmdXlxjGIy8hlcTxe8lmbZHUTfXz0Qd8w=;
        b=2JGjs2a/nYurn/zhtkGD1bH+DBPo/pYf0c7vUP9/hpA7kEx2K05owmvDSMqlHrIEyd
         QSUGClgRkVQDJFxKrzD0LrpaOFLxo85Q7SLsb3TO62PrL4/0PB9rEyM4m4rrgzrWjahq
         V4w0r38+J+mtqQcpeoRt662l8S+MwP8lFsBNWgvHi39Xgz9F/oNXOQMASSo/izGG2/l8
         /ss7n2Rw1BngihqHDBPhKl2j64qfZcitLKf+/LEtE7T0Ub0vQ9NNK43Z22Br6MtYWhDs
         DTpr3Ia67s/IH5m/ybn/ekRFaiT2T8Uuv5XfuxlT3iawF9iwIGxiGVoTo6JWkNmESFrD
         TbRA==
X-Gm-Message-State: AOAM531DJSE2DBFHLMmeE0WqwiqAko0sJcy5B+X4e0Jn1axjJnr5UpZF
        BxBlCnknaLqipia3iercfK+UL0aQW/7LGdXqhgcfN3p7enugoaXsXvdD+UHRUejhPnKTKmSmDnP
        2S2avuOhEZex1XstV6I378Hum9osPKL+Osp+49I2kFr+ZXWSwztXStw==
X-Received: by 2002:a05:6808:124c:b0:2f9:c7cf:146 with SMTP id o12-20020a056808124c00b002f9c7cf0146mr1655276oiv.54.1650032791020;
        Fri, 15 Apr 2022 07:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLRc42uKkOW9jRr8zGyO4TRYeWat9aikXqDx0Q0Pk1DISGwEXTIxuzl6vUfgU29zi70pptiplIF+LuV40c7wQ=
X-Received: by 2002:a05:6808:124c:b0:2f9:c7cf:146 with SMTP id
 o12-20020a056808124c00b002f9c7cf0146mr1655264oiv.54.1650032790778; Fri, 15
 Apr 2022 07:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p4r1v_sN=8kv_fOx_VEb3k=4rU9iw52LfmEHO1crnms=g@mail.gmail.com>
 <20220414164134.GA751756@bhelgaas>
In-Reply-To: <20220414164134.GA751756@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 15 Apr 2022 22:26:19 +0800
Message-ID: <CAAd53p6DX2C7KVRV=uu_mmPTTjE7=RsXfNPxjbOBLRbf-pXi5A@mail.gmail.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Kenneth R. Crudup" <kenny@panix.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        chris.packham@alliedtelesis.co.nz, yangyicong@hisilicon.com,
        treding@nvidia.com, jonathanh@nvidia.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Ricky Wu <ricky_wu@realtek.com>,
        Rajat Jain <rajatja@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Victor Ding <victording@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 15, 2022 at 12:41 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Apr 13, 2022 at 08:19:26AM +0800, Kai-Heng Feng wrote:
> > On Wed, Apr 13, 2022 at 6:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > ...
>
> > >   - For L1 PM Substates configuration, sec 5.5.4 says that both ports
> > >     must be configured while ASPM L1 is disabled, but I don't think we
> > >     currently guarantee this: we restore all the upstream component
> > >     state first, and we don't know the ASPM state of the downstream
> > >     one.  Maybe we need to:
> > >
> > >       * When restoring upstream component,
> > >           + disable its ASPM
> > >
> > >       * When restoring downstream component,
> > >           + disable its ASPM
> > >           + restore upstream component's LTR, L1SS
> > >           + restore downstream component's LTR, L1SS
> > >           + restore upstream component's ASPM
> > >           + restore downstream component's ASPM
> >
> > Right now L1SS isn't reprogrammed after S3, and that causes WD NVMe
> > starts to spew lots of AER errors.
>
> Right now we don't fully restore L1SS-related state after S3, so maybe
> there's some inconsistency that leads to the AER errors.
>
> Could you collect the "lspci -vv" state before and after S3 so we can
> compare them?
>
> > So yes please restore L1SS upon resume. Meanwhile I am asking vendor
> > _why_ restoring L1SS is crucial for it to work.
> >
> > I also wonder what's the purpose of pcie_aspm_pm_state_change()? Can't
> > we just restore ASPM bits like other configs?
>
> Good question.  What's the context?  This is in the
> pci_raw_set_power_state() path, not the pci_restore_state() path, so
> seems like a separate discussion.

Because this patch alone doesn't restore T_PwrOn and LTR1.2_Threshold.

So I forced the pcie_aspm_pm_state_change() calling path to eventually
call aspm_calc_l1ss_info() which solved the problem for me.

Let me investigate a bit further.

Kai-Heng

>
> Bjorn
