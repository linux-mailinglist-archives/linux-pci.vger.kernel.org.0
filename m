Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4D6A1575
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 04:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjBXDjR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 22:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXDjQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 22:39:16 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1995414E8E
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 19:39:14 -0800 (PST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 74F353F57F
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 03:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677209953;
        bh=LvpymLUbODHZ4Mo00qWLmVpjnxYdZJ0xxMFsKmLrd74=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=skfPlk9hGD9JACenRp6ojAbGRcl3CrzNjXydiIWpmAMkPcopObstHRuQdgDneaudw
         TSEptR8ZVSUufRWYX1u3kkRZ/QOLodHhXwbHKm8b74ER7E6+xACGa0BSEvFXsmRiqC
         Xn6X2l+HLeppRub8nfdbttgVfvQriUg80cgkqxYCPc61NjnutkfTvZmcqK1tyfaUrY
         DPJYzO23FybcDF57Jt65ui/R4kDSONDfzXXHX+GRFIVQQb8vlOv9rMeChLvVKvoXC8
         lVuVHMz6Cd7KmnlMI6mEpXmbHrTn0c41xiiLFXAVPmqTV+3q0y9dF94YRtlLGMZkgH
         +j1/uybKZNW4Q==
Received: by mail-pg1-f198.google.com with SMTP id 79-20020a630452000000b005030840e570so656445pge.9
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 19:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvpymLUbODHZ4Mo00qWLmVpjnxYdZJ0xxMFsKmLrd74=;
        b=1U3wig/QZU+ENfZgZZLsXkLFPrbiWZJ7aMm17C1tUg5ndzisVEFb3QDL70qFJwjj+3
         iASEpKqc7JpFUZYJdoXYUcAyysDEoRibzgiEn+l8OvH5LUdrOISQ8wJ2vkpIVbOw1Vbs
         2/3To12M6js55TWeYTrgmD1jLuufYYHxVyU/fCsgHaIHkzjQ9M32L3b32hZjAja+LSlC
         jCADxHo7pTH9orRXLvAGydGgwx+UOs6prx0+myHt3zE5xo9EWUFowqHrOD+sgttGFH3N
         mONOSPYmm0taneJG6C7Z426+/ScWvmguxiE8vACPUOSzQncxvQB0jDjFFn4RH0wVTn6b
         IOZw==
X-Gm-Message-State: AO0yUKXM1qkrcIMMoQdekPPtv42G94WkUfqHZmJTqjQ3D9h6r+m1ZrkB
        tZyclz5mNa6qyXURY5gfz7i9v/vCeBYXw2sq2MobPXHJCiBEIrC+N3AP4lAuavQKhwtoRsAq0Z9
        oNnnGNmfBNtN8ALHuMpTFWwZLWnDtJ2W4Eor0RnL2Occn08QmKP3MJQ==
X-Received: by 2002:a17:902:c3cd:b0:19c:a3be:a4f3 with SMTP id j13-20020a170902c3cd00b0019ca3bea4f3mr1811093plj.4.1677209951572;
        Thu, 23 Feb 2023 19:39:11 -0800 (PST)
X-Google-Smtp-Source: AK7set9zi8Z6ymjynDbJ1bv4R019r6ipAEWDuZlP1cNc9u9M+NCmiZ7E0/bSyF0hgJAcuEy3QZN2T2SFFoSYNKs66fY=
X-Received: by 2002:a17:902:c3cd:b0:19c:a3be:a4f3 with SMTP id
 j13-20020a170902c3cd00b0019ca3bea4f3mr1811084plj.4.1677209951159; Thu, 23 Feb
 2023 19:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20230221023849.1906728-1-kai.heng.feng@canonical.com>
 <20230221023849.1906728-7-kai.heng.feng@canonical.com> <b2bae4bb-0dbe-be80-3849-f46395c05cd2@gmail.com>
 <CAAd53p79Of-ZPBFGtBZCSnST+oTT5AwGkRo_Z57Gm9XDOBmi_A@mail.gmail.com>
In-Reply-To: <CAAd53p79Of-ZPBFGtBZCSnST+oTT5AwGkRo_Z57Gm9XDOBmi_A@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 24 Feb 2023 11:38:59 +0800
Message-ID: <CAAd53p5NdHgC8syFqKUZkfZ4-Z7VcYANbLDPCZ4DexacR+nZEA@mail.gmail.com>
Subject: Re: [PATCH v8 RESEND 6/6] r8169: Disable ASPM while doing NAPI poll
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd@realtek.com, bhelgaas@google.com, koba.ko@canonical.com,
        acelan.kao@canonical.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com,
        rafael.j.wysocki@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 22, 2023 at 9:03 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Tue, Feb 21, 2023 at 7:09 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >
> > On 21.02.2023 03:38, Kai-Heng Feng wrote:
> > > NAPI poll of Realtek NICs don't seem to perform well ASPM is enabled.
> > > The vendor driver uses a mechanism called "dynamic ASPM" to toggle ASPM
> > > based on the packet number in given time period.
> > >
> > > Instead of implementing "dynamic ASPM", use a more straightforward way
> > > by disabling ASPM during NAPI poll, as a similar approach was
> > > implemented to solve slow performance on Realtek wireless NIC, see
> > > commit 24f5e38a13b5 ("rtw88: Disable PCIe ASPM while doing NAPI poll on
> > > 8821CE").
> > >
> > > Since NAPI poll should be handled as fast as possible, also remove the
> > > delay in rtl_hw_aspm_clkreq_enable() which was added by commit
> > > 94235460f9ea ("r8169: Align ASPM/CLKREQ setting function with vendor
> > > driver").
> > >
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v8:
> > >  - New patch.
> > >
> > >  drivers/net/ethernet/realtek/r8169_main.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > > index 897f90b48bba6..4d4a802346ae3 100644
> > > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > > @@ -2711,8 +2711,6 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
> > >               RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> > >               RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> > >       }
> > > -
> > > -     udelay(10);
> > >  }
> > >
> > >  static void rtl_set_fifo_size(struct rtl8169_private *tp, u16 rx_stat,
> > > @@ -4577,6 +4575,12 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
> > >       struct net_device *dev = tp->dev;
> > >       int work_done;
> > >
> > > +     if (tp->aspm_manageable) {
> > > +             rtl_unlock_config_regs(tp);
> >
> > NAPI poll runs in softirq context (except for threaded NAPI).
> > Therefore you should use a spinlock instead of a mutex.
>
> You are right. Will change it in next revision.
>
> >
> > > +             rtl_hw_aspm_clkreq_enable(tp, false);
> > > +             rtl_lock_config_regs(tp);
> > > +     }
> > > +
> > >       rtl_tx(dev, tp, budget);
> > >
> > >       work_done = rtl_rx(dev, tp, budget);
> > > @@ -4584,6 +4588,12 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
> > >       if (work_done < budget && napi_complete_done(napi, work_done))
> > >               rtl_irq_enable(tp);
> > >
> > > +     if (tp->aspm_manageable) {
> > > +             rtl_unlock_config_regs(tp);
> > > +             rtl_hw_aspm_clkreq_enable(tp, true);
> > > +             rtl_lock_config_regs(tp);
> >
> > Why not moving lock/unlock into rtl_hw_aspm_clkreq_enable()?
>
> Because where it gets called at other places don't need the lock.
> But yes this will make it easier to read, will do in next revision.

We can't do that because it creates deadlock:
rtl_hw_start()
  rtl_unlock_config_regs()
  rtl_hw_start_8168()
  rtl_hw_config()
    rtl_hw_start_8168h_1()
      rtl_hw_aspm_clkreq_enable()

Kai-Heng

>
> Kai-Heng
>
> >
> > > +     }
> > > +
> > >       return work_done;
> > >  }
> > >
> >
