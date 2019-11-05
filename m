Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA16DF09B8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 23:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfKEWmr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 17:42:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37773 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbfKEWmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 17:42:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id d5so7086518otp.4;
        Tue, 05 Nov 2019 14:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sBGh41G1h1JbppKf6UBQhiBlmkM81zpddPr/OUrL6RQ=;
        b=ZwwhegnrM+lgSCisHRH3n4K3FIoJ4/fdbZIYfZRUFm9IZjfws+/nH/amlbwCbipZEv
         AMcoMCqf99dam0ROSl6+/B6q39ZS2MeM4CjmOCIUAkO70YstFhh2izAmxZfxuJTn/v8q
         jGHZOxjHfOz2P/FVekCbsDhR/UT1LGmXlaGtin2x2qpDyCK+SBs+E1QZm9km4hmN1gfl
         WajT58WMnEyBrCMM+My725Zc6fSdMetJT9bPTrDGNTPVw2UHm5TNA2sNwA9lXbKb5jzq
         +8LsVD9n/95x8JLdeiO6MUVXh5Y4XEAMSpo3Ee5nJKUsleGElTfj4zWtJJfn3OG3OE8t
         RGSw==
X-Gm-Message-State: APjAAAXOJfmMcw/zJhYFSJ0kiES5W/5hidgIIS4KrNqE1MUH1f6p19Sn
        soKqP0qkErKO9pXd8dabcQ==
X-Google-Smtp-Source: APXvYqwP3lM6HMOYFY9i0HBBnj3zSkVoDtyoUikH2mqG7H5s8Sfhj1MAckDIzfPKYO7KNkdSiSYzFg==
X-Received: by 2002:a9d:5e12:: with SMTP id d18mr25004209oti.220.1572993766300;
        Tue, 05 Nov 2019 14:42:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l9sm6411949otn.44.2019.11.05.14.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:42:45 -0800 (PST)
Date:   Tue, 5 Nov 2019 16:42:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Add support for SDM845
 PCIe
Message-ID: <20191105224245.GA32297@bogus>
References: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
 <20191102002721.4091180-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102002721.4091180-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  1 Nov 2019 17:27:20 -0700, Bjorn Andersson wrote:
> Add compatible and necessary clocks and resets definitions for the
> SDM845 PCIe controller.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Split out binding in separate patch
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
