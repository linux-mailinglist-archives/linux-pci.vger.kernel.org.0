Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3814421B84
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 03:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhJEBPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 21:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEBPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 21:15:18 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78333C061749
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 18:13:28 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id l8-20020a4ae2c8000000b002b5ec765d9fso5916179oot.13
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 18:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/QiyAF8stN6WXJkebMYhEKCk+J6tjZCzO5t5KsxkaW8=;
        b=Pwmy9PVWT3pIfz5Si5cRGpSEO6knwSKfjSbmckUtWqpjCvAj4Ewq+zy34wQipF5NOP
         BzEsmNRu/QOV7C0QgcTfv6H/wBxKyfTo/o3vhNXrXI6nZ777vdXbSqjwvkx0raD5xYVS
         ZbieAVrbTEAhJ40hDVqGATk6csUZ14pz0VIQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/QiyAF8stN6WXJkebMYhEKCk+J6tjZCzO5t5KsxkaW8=;
        b=icMqoWBiquP5TW56Tlyqz8dDeCCFeqH+pj0Vks5S1oTValRoegHIrh3hjLCwMoPWVf
         YINj8tPbtnsOMnOhCh9Bv6mQbe5MX/Ps/iH9Td1mlyeKn05Qm8phwcUagxREzSstrokk
         S4SqQrjFBnA6jwMHaz7g5YT+IT9PJWJfmdYK0LhB9wX8TW481IGW9y0Xzpko4OwpJIvy
         K3pJWzNBj7kv8bHD4S0qerFhdqqFabOoG62MXnfetGhkpTXxPBDQfs71javqpO8TLqqH
         QJndsGpbnzmvhoi2+3duXGo6qJNzo375t1K9R4pCNIOGjflmkCapXOJZpuprwVjxt3Z6
         lErA==
X-Gm-Message-State: AOAM531w9kJ9HRKkNADu6HFXLMn9QBZCNbZ0KU2/Nj8yKlH0vTPZT5Jr
        gPCYv6d23GPJiVRNvIRgheZDM7GGh27BeK7R5JpESw==
X-Google-Smtp-Source: ABdhPJzGa90ACbuF6mgv6oFURLXi+3lJ8M+6w5Brhzs0n9UVBZGhvuUbVVBefiJt5y9Yi2qiXsK00OBN15wA9+TjFYc=
X-Received: by 2002:a4a:8508:: with SMTP id k8mr5453028ooh.25.1633396407883;
 Mon, 04 Oct 2021 18:13:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Oct 2021 21:13:27 -0400
MIME-Version: 1.0
In-Reply-To: <1633376488-545-5-git-send-email-pmaliset@codeaurora.org>
References: <1633376488-545-1-git-send-email-pmaliset@codeaurora.org> <1633376488-545-5-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 4 Oct 2021 21:13:27 -0400
Message-ID: <CAE-0n51S8VV5b5SEuh041dUvgd2_nqQ3JTXAjMzJfcok0xhi8w@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] PCI: qcom: Add a flag in match data along with ops
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

Quoting Prasad Malisetty (2021-10-04 12:41:27)
> @@ -1488,7 +1528,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>
>         pcie->pci = pci;
>
> -       pcie->ops = of_device_get_match_data(dev);
> +       pcie_cfg = of_device_get_match_data(dev);
> +       pcie->ops = pcie_cfg->ops;
> +       if (!pcie->ops) {

Sorry I meant check for pcie_cfg being NULL too.
of_device_get_match_data() can return NULL if the match doesn't work for
some reason.

> +               dev_err(dev, "Invalid platform data\n");
> +               return -EINVAL;
> +       }
> +       pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
>
>         pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>         if (IS_ERR(pcie->reset)) {
