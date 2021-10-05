Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536C6423062
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhJESwn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbhJESwl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 14:52:41 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2AEC061755
        for <linux-pci@vger.kernel.org>; Tue,  5 Oct 2021 11:50:50 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso55192otb.11
        for <linux-pci@vger.kernel.org>; Tue, 05 Oct 2021 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Xo0OGV/ZUiPKgbD5HPrkjo/F/a3NnSi3YP8gAkh8iCY=;
        b=TLXgjh4ToYp4L5wZ9wa2GsVgHenprfEFVxFIhITFK0WYtOWIaJF8j4qZ6/RAQ9C1r6
         EpvOaDxqumTiruAkli7zPPmCKL0JSrF9LfGknFKwVgzHYam4/+1+Rr9UnfZlEU6cIl9U
         d8Q6IKYeC3/AyJhc+AeQmAzNNc8w99c60xeLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Xo0OGV/ZUiPKgbD5HPrkjo/F/a3NnSi3YP8gAkh8iCY=;
        b=wxjHE7He6khobPpZNGsn5lIX/DgTB6X7K11JaKwkpARmRbgECThKMrrbST6puucvsg
         b/89cH3ygwaM9TpY0SQUIH+pb/LWG8L1xuHJCrx+vjQJTaha7yNkf82mZYzhLvp5ovY1
         SEPuARgErVr9UEjhcbg0VSgb7Vu2wZvMOw9LTCJ9+6OFdugXp48UPN1U0rcSa4AbM3d2
         Z12o2vdQA6z1oOwP0W9FqCABPeG7kJlp68YuThbpllTwxzqXO6ipr+2WSBuZt/bJuPrg
         u8Y7TakZB9rnEcV1ljxlz6k2nqMzeNmkKjM11RnO7xRa7vaWpKYX24vovNi8S0Vjga9R
         Q54A==
X-Gm-Message-State: AOAM5339AAF7xALU5C+lWlTkX0TqvBY4A8GY69wpHUZHIqMkoSjycGWn
        NBAiI62JSzWTUVEkw6cwilHCcMjGHnrKaKy//Q8oqw==
X-Google-Smtp-Source: ABdhPJxre14riLWd/0Vk02OXaJCmQW1uYI8QN3QfKNpl8EpzGV8Umsr6ysW7Vq58lYjpRA0Ei9xoDL68KK8/ibgSmx8=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr16259964otn.126.1633459849811;
 Tue, 05 Oct 2021 11:50:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Oct 2021 11:50:49 -0700
MIME-Version: 1.0
In-Reply-To: <1633459359-31517-4-git-send-email-pmaliset@codeaurora.org>
References: <1633459359-31517-1-git-send-email-pmaliset@codeaurora.org> <1633459359-31517-4-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 5 Oct 2021 11:50:49 -0700
Message-ID: <CAE-0n521dCW4mc_Fu=YZ8w-DOwrE_+4S1tmU3WUzA0B9ODfYUg@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Prasad Malisetty (2021-10-05 11:42:37)
> Enable PCIe controller and PHY for sc7280 IDP board.
> Add specific NVMe GPIO entries for SKU1 and SKU2 support.
>
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
