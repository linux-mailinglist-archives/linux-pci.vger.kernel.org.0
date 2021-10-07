Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B2F425A38
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 20:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbhJGSD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 14:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243424AbhJGSD2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 14:03:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59EC061764
        for <linux-pci@vger.kernel.org>; Thu,  7 Oct 2021 11:01:34 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t4so8311114oie.5
        for <linux-pci@vger.kernel.org>; Thu, 07 Oct 2021 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=l/jHmdsNTaCbqb/3iY1ubX++haNMV1LDyfyVcpuyCNU=;
        b=gMIpgNRcHWiBlfWidWRVcnFOODsqVojhqfmUWh0slCQPAeHdEEyceqbZIIIsxB2zNy
         nccHjL2bqqStmVVkYH72v8oJq3DyIFrAbUvhQ8DIsHfAIuKPJiHZmmFfVqmQ37R+Szpx
         TmXiymP/d//qpRYSvYziMFjajCB3JhlIy0sxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=l/jHmdsNTaCbqb/3iY1ubX++haNMV1LDyfyVcpuyCNU=;
        b=wXNcM5JEl3zfU2Y6iT6znM3H3UNfzEnJKdLgodH+htGLP+fHs/Bii+REvIkXtT7JSH
         BeDB/vJsB0QcJ0j1JSXkkCZ0vsISQYmXj2olzxbixyxoJvoxEE3YQtyiz2MrtCGxbe+K
         1sJjLukThXXy/yeHlKlKU2Et2BfAnQufsl9ehch6QElbct1Ru6sWWFmEa5Ri36j5Fdbw
         tm5nAeWjYCrPf+D3jRsXp74lXoaqRk8SNa+kalPQFoWzpFW8CdLhjnHk6SQ/ojEGt/X3
         EGVxl6odtXg2Wpeb4o/xDaVtQQFxpm5uMCtg315fPvMKtyjRuLcjF8oR7VEP9LNk0XNQ
         wY5Q==
X-Gm-Message-State: AOAM532udr9eeWjXtz6YdTZkda26u2v1+go2WaBStVdIAvus+GxpIO0i
        YEQtLQFc1O9I/kLchWos3Izqzahz6xb6gGVCAgNgEA==
X-Google-Smtp-Source: ABdhPJzyJhAIMwWYX0j+dskBijdHRK2EqFvl+pGpjSoNbQ0EmOLi/qyKR7XkJBsTAK1+izQUXcpyDHtFQSZNmCiRpHE=
X-Received: by 2002:aca:f02:: with SMTP id 2mr4350822oip.64.1633629693863;
 Thu, 07 Oct 2021 11:01:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Oct 2021 14:01:33 -0400
MIME-Version: 1.0
In-Reply-To: <1633628923-25047-4-git-send-email-pmaliset@codeaurora.org>
References: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org> <1633628923-25047-4-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 7 Oct 2021 14:01:33 -0400
Message-ID: <CAE-0n53kd+eZpX1jv2U_uQe3res+s69uDnw0862yOqYzWO_JvA@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
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

Quoting Prasad Malisetty (2021-10-07 10:48:41)
> Enable PCIe controller and PHY for sc7280 IDP board.
> Add specific NVMe GPIO entries for SKU1 and SKU2 support.
>
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
