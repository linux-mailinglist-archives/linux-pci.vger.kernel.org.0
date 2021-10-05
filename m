Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C76423066
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJESxt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhJESxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 14:53:48 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E7FC061755
        for <linux-pci@vger.kernel.org>; Tue,  5 Oct 2021 11:51:57 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id v10so531425oic.12
        for <linux-pci@vger.kernel.org>; Tue, 05 Oct 2021 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=LIIZhO6QemCxBZ+WNeUA1NEuSGEugkxriOxoUlLOrtM=;
        b=Y1nq5bwPYgRtZSjzARwnqT6iVgQ/xdr6g8NM7LasqBqbPZpI4zP1qfDtiPCm3SaWPr
         jrdpR5Tx34tO4K7ERkIGnrUhYh3+v/jVh5GhPPfbfud6u6GE5I6i0Rr4W/eNnlf8HALN
         BsGPH1DMJw5cFM9cMKPantLExCmTQIv+nQip4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=LIIZhO6QemCxBZ+WNeUA1NEuSGEugkxriOxoUlLOrtM=;
        b=bHgnCTAkVcEF8447Zscym0+hZlAamSZkFIiGGnZjwUYxDnzmmTnCUaV65t/vGdNwkI
         /pEeYEJNr3d1T4GsP4v7AFapE8sex3uO559V8Syr62dzN7StUZO11+c9I9Pd5Vhi7qqr
         R8zOja+MJIjYJ9z+mH0dcN3aeJX+0nPoDv3GrGQiugSVCy7Kk3S8hzDwENJMdpLoOOtt
         9kPOGQCvvMig/nXI/H8iPK2gbr3aWDcerbuXH+Uedku7gfFKjVwwPwBStI3QVSmaJVwK
         dyMPuhTbf4nZVUUCAMSVhA0hG3K52y8oz4pM9qXJsyUSRzoUYpamaY4lbYdDrfB1mz6d
         P82w==
X-Gm-Message-State: AOAM533CiXIplm2FwUIpztMGsEYn90VIlgHO9Rd1MBZx61iiuGImswOa
        tn/IZKfOpi4qT4w5aDILtdwitqjlEWUu5OCwlLKLhA==
X-Google-Smtp-Source: ABdhPJx3bk6kPZwvGXnigGeMH3u2Pd/DyxwzdF0vLz40GZdxglzimeBZyFdhqzgXgqztcirSxk8zy1Y/fjFQiUbZmPM=
X-Received: by 2002:aca:3110:: with SMTP id x16mr3979222oix.64.1633459917288;
 Tue, 05 Oct 2021 11:51:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Oct 2021 11:51:56 -0700
MIME-Version: 1.0
In-Reply-To: <1633459359-31517-5-git-send-email-pmaliset@codeaurora.org>
References: <1633459359-31517-1-git-send-email-pmaliset@codeaurora.org> <1633459359-31517-5-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 5 Oct 2021 11:51:56 -0700
Message-ID: <CAE-0n511H+FbPCbSb+FP0VMsrTmA4h8Q9pfk-=4zZPnwLuRAPQ@mail.gmail.com>
Subject: Re: [PATCH v11 4/5] PCI: qcom: Add a flag in match data along with ops
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

Quoting Prasad Malisetty (2021-10-05 11:42:38)
> Add pipe_clk_need_muxing flag in match data and configure
> If the platform needs to switch pipe_clk_src.
>
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
