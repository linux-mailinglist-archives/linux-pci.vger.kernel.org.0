Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D152BD5A
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiERN2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 09:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbiERN1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 09:27:39 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79EA187060;
        Wed, 18 May 2022 06:27:34 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id i187so1417289ybg.6;
        Wed, 18 May 2022 06:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyQ6Fx0ZnY45xGr5Y2jsnDq8ZWgzz0EhlHFyuG9haXs=;
        b=jIbvSAFezObjbcXOkwoWA6ady+/4pTpFk4TJfVmfhAT9ZOKUp3xcV4QgK8KBs0Jjgz
         zHz8/X3uiiF7pTgPTuXB1AFjl20dqM1YVo1JQLSSvbOInLZJ/MYBV6C/k7eJAMzgJ6UG
         x6N9TfeRqBss5FxrDsJiBiWDPynRSTiP4xAel5dcrEcx3/TKYqATa5mE3AVCElYApsEx
         hh/zyFIzGA4vRn9ttSqafdalAEJIm+ZTnTDjb1hfPw8OtPhiqOA+9ZyAIASv4CQDcGsD
         RC7hAJvjpyYna0lbGeAfSNk5ATo0WhX+i6Bz2pZZlcyhKDbu/UUkAbowEv11Ph/PpZPa
         jcVA==
X-Gm-Message-State: AOAM530EFt7ULcNK8jK933dS0HZ+NSQ6FVm1s0w5XUOKTlGP8xKn2DJ+
        dNF0xJXkkJVVeVvC/dQEjk/lMFV74+6WdMjMMl+asPOt
X-Google-Smtp-Source: ABdhPJyjRx5gA7bKsO07czfdltoky1/Nf4DCcgRm0CA+ey3YCQSpZFTINNpWzDS3Y96jPW58VJCCVFx1k4Cf/+aYtDE=
X-Received: by 2002:a25:e7ce:0:b0:64d:6028:96b9 with SMTP id
 e197-20020a25e7ce000000b0064d602896b9mr19858608ybh.365.1652880452946; Wed, 18
 May 2022 06:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 May 2022 15:27:22 +0200
Message-ID: <CAJZ5v0hLtU=naptVYfp9ZmLeWzJREQ1icWJYrjh+a5LqOYG4Dw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCI: Notify PCI drivers about powerdown during suspend
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        svarbanov@mm-sol.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jens Axboe <axboe@fb.com>, quic_vbadigan@quicinc.com,
        quic_krichai@quicinc.com, quic_nitirawa@quicinc.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 3:19 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi,
>
> This series adds support for notifying the PCI drivers like NVMe about the
> transition of PCI devices into powerdown mode during system suspend.

What kind of system suspend are you referring to?  Suspend-to-idle or
suspend-to-RAM?

For suspend-to-RAM this series should not be necessary at all, because
drivers cannot assume that the state of devices will be preserved
anyway in this case.

For suspend-to-idle, drivers can expect the preservation of the device
state, so perhaps the firmware should be prevented from powering them
off in the suspend-to-idle path instead.
