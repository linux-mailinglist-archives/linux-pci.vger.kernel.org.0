Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75792716F5B
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 23:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjE3VGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjE3VGX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 17:06:23 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A999
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 14:06:20 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33b9d3bf820so3239325ab.3
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685480780; x=1688072780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g/W4+fMbLyvPTIx2245PdFuagwhAk+C64FSemMkW2UM=;
        b=GWTEm3W1HqO2zGOjVcoEgEy8JTHYtvWUdHsreZW0kzb5sX2O/2mKJoPeFA/q0ynbvH
         SqdFJVTAlD6PuHRf5Vh/J4AFD4vDpdGBWp9LRLFmaSAf80rNKNo91WEGzfrEB2nnGLgN
         QO06IclO39iDE+D9XO3ZPyF2thLdc+Q4+0W18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685480780; x=1688072780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/W4+fMbLyvPTIx2245PdFuagwhAk+C64FSemMkW2UM=;
        b=F8IS4M7m1EeyUyqKWQ1HWxYwD9S+fpwOvTyUV22g63T+UX62R5E9KzF99U2B4+HWRm
         DH1nkf8R5UXJzRZRM59/xkWKR2eyq/nfVMB9EvPKlvAnOi5Eln23IGtJp3jMfCiCQtel
         67KA2f6SW2UxUKW4rwgRqjsXOIZfJ/+SfYG5OpeaJ9dR5o7mi/j7wImZLRCVff2ile1D
         1wLzrdCUXly5r0O4JCXnFVNgCx9mC+VkKjnCbk5nv3Fh24aV8TmkdE8IO7s9FHPOcNxv
         YOZ0bCpgkXJny1/g1Z8Dt3Wl91tg5LaxP5h2csaq2HgnoWGl2vgum/qGT21gqMG0vTLd
         fjEA==
X-Gm-Message-State: AC+VfDySVx8jE7/lxa3/v9ZVLfX1P7pcIADYfKwxjRf56TmBANIZaswm
        W+YaCjseusN7j3GOyseTj+vfrg==
X-Google-Smtp-Source: ACHHUZ4oQouosWLOAan/NlY1g7ARDDIDcAnRzfg15YFFFDchHSY1YFtu/S9EHFWVZMzmUpK8q/x45Q==
X-Received: by 2002:a92:4b08:0:b0:335:fc8:9b4 with SMTP id m8-20020a924b08000000b003350fc809b4mr485691ilg.19.1685480779840;
        Tue, 30 May 2023 14:06:19 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id dj10-20020a0566384b8a00b00411af6e8091sm1006419jab.66.2023.05.30.14.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 14:06:19 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
X-Google-Original-From: Matthias Kaehlcke <mka@google.com>
Date:   Tue, 30 May 2023 21:06:19 +0000
To:     =?utf-8?B?5qWK5a6X57+w?= <ecs.taipeikernel@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] drivers: pci: quirks: Add suspend fixup for SSD on
 sc7280
Message-ID: <ZHZlS48EKigmNihh@google.com>
References: <20230525163448.v1.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
 <ZG/c1+/mCp/PfFSO@bhelgaas>
 <CAPao8GJNbXnh1R2-9rueMygyYyy-r3kqvQ55xdN61E7m6_dkdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPao8GJNbXnh1R2-9rueMygyYyy-r3kqvQ55xdN61E7m6_dkdw@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 29, 2023 at 02:24:53PM +0800, 楊宗翰 wrote:
> Hi Bjorn,
> 
> Thanks for your kindÂ directions.
> 
> Â  - Subject line in style of the file (use "git log --oneline
> Â  Â  drivers/pci/quirks.c").
> Done, and I resend in topic "[PATCH v1] PCI: Add suspend fixup for SSD
> Â on sc7280", please review it.
> 
> Â  - Format commit log correctly (fill 75 columns, no leading spaces).
> Done.
> 
> Â  - Description of incorrect behavior.Â  What does the user see?Â  If
> Â  Â  there's a bug report, include a link to it.
> This issue seems to be discovered in ChromeOS only. SSD will randomlyÂ 
> crashed at 100~250+ suspend/resume cycle. Phison and QualcommÂ 
> found that its due to NVMe entering D3cold instead of L1ss.

It should be noted that D3cold (or whatever condition that causes the
issue) is not always entered, but only in the failure case (at least
that was the case for the Kioxia NVMe, which has a similar issue).

> Â  - Multi-line code comments in style of the file (look at existing
> Â  Â  comments in the file).
> Done.
> 
> Â  - Details of "the correct ASPM state".Â  ASPM may be enabled or
> Â  Â  disabled by the user, so you can't assume any particular ASPM
> Â  Â  configuration.
> According to Qualcomm. This issue has been found last year and they have
> attempt to submit some patches to fix the pci suspend behavior.Â 
> (ref:https://patchwork.kernel.org/project/linux-arm-msm/list/?
> series=665060&state=%2A&archive=both).Â 
> But somehow these patches were rejected because of its complexity. AndÂ 
> we've got advise from Google that it will be more efficient that we implementÂ 
> a quirks to fix this issue.

IIRC the primary goal of this series was to be able to turn off the
PCI clocks during suspend, to allow the SoC to enter a lower power
state. This fixing element for NVMe with the issue described above
is the the retry loop of "PCI: qcom: Add retry logic for link to be
stable in L1ss" [1].

It is currently unclear why *some* NVMe *sometimes* need a longer
time to enter the L1 sub-state. That's something Qualcomm and the
vendors of impacted NVMes should figure out.

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1659526134-22978-4-git-send-email-quic_krichai@quicinc.com/

> Â  - Details on the Qualcomm sc7280 connection.Â  This quirk would
> Â  Â  affect Phison SSDs on *all* platforms, not just sc7280.Â  I don't
> Â  Â  want to slow down suspend on all platforms just for a sc7280
> Â  Â  issue.

As of now the issue has only been observed on QC SC7280, I don't
know if ECS has tried this part on other platforms. The issue could
be QC/SC7280-specific or not.

> The DECLARE_PCI_FIXUP_SUSPEND function has already specify the PCI deviceÂ 
> ID. And this SSD will only be used at our Chromebook device only.

It could be used in devices that are produced by other manufacturers.

A dedicated Kconfig option for the Phison NVMe could be an option.
Or a QC specific #ifdef (ugh ...) with a comment explaining that the
issue has been only observed on QC SC7280 *so far*.
