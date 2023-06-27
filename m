Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5542C73F68E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjF0INM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 04:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF0INL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 04:13:11 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F50510FD
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 01:13:10 -0700 (PDT)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6A26F3F13F
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687853587;
        bh=gg3OEKCdXYQ44h8MuGgBj8DaSBevkCPyPNd3zprHKaY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=l9VaXRFlSrjjfvIddCX0D+ROs32wEd2nMlQOpqXXFhArBSn8aIQgInZl2tJIQbx+g
         c/VYK+CqPkiQm5bm/KuiVs2hKc+C2TjepLnAJiegKcDa5jBEmrFXj3g4HUCd6EstsO
         lp361EIJgx57lWIu/mSPRzVljwSAHqgufkqsPNoY8YxQtfk7imkbsuPULwdQr1cv0K
         MrnEE1vQv6arI6vBsGs4VMFH4iRNGjm294EEwZnITKbsaKIR/tvMOQg+y1khaq+Od2
         +2x03hd1ZSE2aurJONpHYGevlgjF5tFV2CM7Q1wVoaLoZdpyqRyh27CnvJgeWLhSMW
         1XGNAfvU0Sn2Q==
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765986c0521so198261685a.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 01:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853585; x=1690445585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg3OEKCdXYQ44h8MuGgBj8DaSBevkCPyPNd3zprHKaY=;
        b=FR0kNZ2P8EttzSzujUIzdruhYsLVySl8XgYDrJ/LU8TzzN1LlEFMFyvCLvNobRpm8B
         8EbIuwogZJKcwb/AI30ewTcT+R17yR2I1aAnbtl9bSOOHSbQ0bs0D3lXafJkp9avWtHI
         s4W7VnUnUAx++XV7lxBKmhjJJFqb+BjnXhdCTXPHgwLDK12q/qDm6Ngt2QNGEAeL/3qQ
         I23r1xKKyhmYTnKKjY4xKYS3PyNzlolopVmdURorOjnXSF5A2qFmvrZtLZ6Oy8C8CUzL
         NrQ84LFRZOFZm1XguQpG2X6jiw1NAxIP6Q5x+Du6atnD+ms5JH9tgTYfnrk6B+xxiZ9c
         yp9g==
X-Gm-Message-State: AC+VfDwj85Uir4iG1M4XKsnalKKQ8CQPDMZxRlYx5DL3n+7S+di3fI50
        mC5N0dGo07gVURyshaLXpmEO0bKBtlws2skw8wfruRAtRuq5GSj2L748oj/uWOPceDzyuyWNt3s
        ANh9VuBtjON2W5p+0BRnisTlV+1+7kmyj/ckjSTr+69qY41PCM+ieFw==
X-Received: by 2002:a05:620a:b5d:b0:765:a99c:96f3 with SMTP id x29-20020a05620a0b5d00b00765a99c96f3mr3991327qkg.28.1687853585408;
        Tue, 27 Jun 2023 01:13:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5fgqyY3eOukJw2FU7SKafinmfoAL+d8SvblNvlFQgx5Qor6fZJCGh2ay3cp5ysEdiBq4nqsWO1NHqtqMWrOIU=
X-Received: by 2002:a05:620a:b5d:b0:765:a99c:96f3 with SMTP id
 x29-20020a05620a0b5d00b00765a99c96f3mr3991319qkg.28.1687853585132; Tue, 27
 Jun 2023 01:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <16bcc313-a4e1-ab50-4487-c99ccf5ecdf9@intel.com> <20230622131123.GA137990@bhelgaas>
In-Reply-To: <20230622131123.GA137990@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 27 Jun 2023 16:12:53 +0800
Message-ID: <CAAd53p7EXmqe2CMnrVGK_DUcQZVxCPwcFdVFkPPSUZaPDjwz0g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] igc: Ignore AER reset when device is suspended
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>, linux-pci@vger.kernel.org,
        "Mushayev, Nikolay" <nikolay.mushayev@intel.com>,
        linux-kernel@vger.kernel.org, jesse.brandeburg@intel.com,
        "Edri, Michael" <michael.edri@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Dumazet <edumazet@google.com>, anthony.l.nguyen@intel.com,
        linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Paolo Abeni <pabeni@redhat.com>,
        "Avivi, Amir" <amir.avivi@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 22, 2023 at 9:11=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Jun 22, 2023 at 08:09:34AM +0300, Neftin, Sasha wrote:
> > On 6/21/2023 23:43, Bjorn Helgaas wrote:
> > > On Tue, Jun 20, 2023 at 08:36:36PM +0800, Kai-Heng Feng wrote:
> > > > When a system that connects to a Thunderbolt dock equipped with I22=
5,
> > > > I225 stops working after S3 resume:
>
> > > > The issue is that the PTM requests are sending before driver resume=
s the
> > > > device. Since the issue can also be observed on Windows, it's quite
> > > > likely a firmware/hardwar limitation.
> > >
> > > I thought c01163dbd1b8 ("PCI/PM: Always disable PTM for all devices
> > > during suspend") would turn off PTM.  Is that not working for this
> > > path, or are we re-enabling PTM incorrectly, or something else?
> >
> > I think we hit on the HW bug here. On some i225/6 parts, PTM requests a=
re
> > sent before SW takes ownership of the device. This patch could help.
>
> Is there an erratum we can read?  If this is needed to work around a
> hardware defect, there should be a comment in the code to that effect,
> and we should have a better understanding because there may be other
> scenarios (suspend/resume, hotplug, etc) that need similar changes.

Actually, similar message can be seen on hotplugging the device. The
AER message will be gone shortly after the driver done it's probing.

>
> (I know this patch is to work around a suspend/resume issue, but the
> change is in the AER error recovery path, so it doesn't quite fit
> together for me yet.)

This is something I really want to discuss.
This is not the first time that AER handling doesn't play well with
system resume because the error handling and resume routine can happen
at the same time. Some possible way going forward:
1) Serialize error recovery and resume routine.
  - If error recovery happens first and it's a successful recovery,
does the resume callback still need to be called?
  - If the device successfully resume, is the error recovery routine
still needed?
 So I think the most plausible way is to call error recovery only if
the resume fails. Ignore the AER if resume success.

2) Disable the AER interrupt during suspend
 - Since the AER is still recorded and AER interrupt gets enabled by
port driver before child device resuming, the error recovery/resume
race can still happen.
 - So the port services resume routines can only be called after the
entire PCIe hierarchy is resumed.

3) Disable the AER service completely during suspend
 - This is what's in my mind. If the AER is caused by firmware and
hardware (like most cases), the most feasible way is to workaround the
issue in the driver.

IMO ether 1) or 2) requires involvements that add little benefit. So
hopefully we can opt to 3).

>
> Are you saying the NIC sends PTM requests when it doesn't have PTM
> Enable set?

I think I mentioned during previous discussion. The PTM gets enabled
by the firmware/hardware on the TBT dock right on S3 resume.
The issue is also logged on Windows' Event Viewer, but hardware vendor
doesn't care at all since the device is still functional :)

>
> What exactly does it mean for "SW to take ownership of the device"?
> What PCIe transaction would tell the device the SW has taken
> ownership?

Please correct me if I am wrong, but Intel ethernet devices may need
the driver to perform some actions so the ownership can be switched
between software and firmware.

Kai-Heng

>
> So far this feels kind of hand-wavey.
>
> > > Checking pci_is_enable() in the .error_detected() callback looks like
> > > a pattern that may need to be replicated in many other drivers, which
> > > makes me think it may not be the best approach.
> > >
> > > > So avoid resetting the device if it's not resumed. Once the device =
is
> > > > fully resumed, the device can work normally.
> > > >
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216850
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/ne=
t/ethernet/intel/igc/igc_main.c
> > > > index fa764190f270..6a46f886ff43 100644
> > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > @@ -6962,6 +6962,9 @@ static pci_ers_result_t igc_io_error_detected=
(struct pci_dev *pdev,
> > > >           struct net_device *netdev =3D pci_get_drvdata(pdev);
> > > >           struct igc_adapter *adapter =3D netdev_priv(netdev);
> > > > + if (!pci_is_enabled(pdev))
> > > > +         return 0;
> > > > +
> > > >           netif_device_detach(netdev);
> > > >           if (state =3D=3D pci_channel_io_perm_failure)
