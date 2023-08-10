Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73E7776E93
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 05:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjHJDeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 23:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjHJDeM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 23:34:12 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382E42100
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 20:34:11 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58411e24eefso6275937b3.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Aug 2023 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1691638450; x=1692243250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owh1PXmuDi3+G1fZ02mr5p8F6eCwrNc9fPU6RwtfNGo=;
        b=IgCP4YL42l4DMFP7qaISiAPr0DbqBeTleqt/D1ym6y1nR7lUNgBbTn4hJpGXEB6x1X
         RXnvujbNKPQ5dzvvNtD/zfJreg69Ot0hw2qRPfCVq74+dHB7BVcLPXxZhAnPc8YbelH7
         jSmvBTM8kpTwqUXaTXUWqvodmHJ+bicAchWIc6yF1n064G7Wy7nFt//W9FNfv5OQ0U77
         2EotOvQXpZ2csIitnr07MP+RQ564D8CoSya1eR7M85yQaYDRZne4wh2qukUxmRDm/Ggn
         Ig67z2EuuZWCAGu2xn0F984ZFQ+xsfqgGMCeEe2YDjYW3EV3NCq1xm0LsnwsFZV3cgR3
         i/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691638450; x=1692243250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Owh1PXmuDi3+G1fZ02mr5p8F6eCwrNc9fPU6RwtfNGo=;
        b=j3OJU7vspeim6KCsnvK1XJob1DdLp+DHj7mcLZ2SzkSBePzRsVACSqa6jtqX3ld91h
         1A5DceSagfiXGjCIIzTiIARLDOj5yJCVXUWsVpyi2LQ3LzsrTUg4wL/OGQC3OK5Hyuqd
         oYMhmcO0oNpbF2NMqCUv1tocHCHx49hsHv43VRmdKBXvspgBrkTYpBiEeNHyEylryclI
         7Ou3bME9URFEdU3WropeeAzNxL49mu8QHiiOfsEp+RtYHuQn3KSo1bKliE+nZ3C3w0mo
         jNNHPGmcqIXGoxsLtE0jdTbzmX2Y4c8vFDUK9X173jtWjsS8reMIyg5sTDpGhTWO+m9Q
         lqpA==
X-Gm-Message-State: AOJu0YxHz7lfviN9VoMSjmwERQHqO8E3I5L3AcIFLlHc+Z2AoPJwvOiA
        kRXDrnHicqMY8U/TpC+LHzn/twh+7pnVHZM5FxuQKQ==
X-Google-Smtp-Source: AGHT+IHkGXkMY5PiCwLbEzVqX2WAd7DAZvuE+jPnwHciFWXu3tnxWrL0PgJ4yRY+eJouQi1/BCc7K5809rixQXdbl2E=
X-Received: by 2002:a81:6956:0:b0:583:fad9:e241 with SMTP id
 e83-20020a816956000000b00583fad9e241mr1550190ywc.18.1691638450434; Wed, 09
 Aug 2023 20:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230809081840.16034-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20230809081840.16034-1-manivannan.sadhasivam@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Wed, 9 Aug 2023 22:33:59 -0500
Message-ID: <CAKXuJqgyCJmWF=LfSGPOr85n0SzLSRbDRvLtfAsw=tXwxXjiCQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: qcom: Enable ASPM on host bridge and devices
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 9, 2023 at 3:19=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi,
>
> This series enables ASPM by default on the host bridge and devices of sel=
ected
> Qcom platforms.
>
> The motivation behind enabling ASPM in the controller driver is provided =
in the
> commit message of patch 2/2.
>
> This series has been tested on SC8280-CRD and Lenovo Thinkpad X13s laptop
> and it helped save ~0.6W of power during runtime.
>
> - Mani
>
> Manivannan Sadhasivam (2):
>   PCI: dwc: Add host_post_init() callback
>   PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops
>
>  .../pci/controller/dwc/pcie-designware-host.c |  3 ++
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c        | 28 +++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> --
> 2.25.1
>
While not extremely scientific, and I don't have any way to measure
the power usage on my Thinkpad X13s, with these patches applied, I've
only gone down 29% battery power in the past 6 hours, suspend and
resume cycles don't see any issues either.

Tested-by: Steev Klimaszewski <steev@kali.org>
