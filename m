Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973E11C98D4
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgEGSHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 14:07:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46617 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgEGSHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 14:07:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id c124so5823802oib.13;
        Thu, 07 May 2020 11:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LAuIZE+9tBbQreQAUqWIU1efH733gN4PuPelENzqY/E=;
        b=FsfLLKHeg6cjO+gJ/cB3aab7njnPOllcIg1KoShH8y5zX6s3aKbzT/x1DXzQAndSrp
         TnVP9VAa8iMsK85nPYSw7eALlQXQBVWSamI7eQep2DzUvxgRj38+uuewCpg52Qn6FU9s
         mFjP8tXIbg4avf3KIA9UuDHIXniLY2IG88kcL4VwjRccCYP0/zkxM4jQl1x+4sh/gK6G
         kw+HwsJKKw4vbfD/t9PCgh5NYj+Q3sadDG+u/L57hpUZ6LIiPHP7o7et5BvYPzlRTf0/
         mC/eV0l7kQf2f4FbYCJ74aaiwRh5VuVvRU1EoIgqSqX6MEvXk0oQnt2scj5IVVRE1sYT
         XZqg==
X-Gm-Message-State: AGi0PuZ36rQoL80bs13XjRU8QT8tWVbuBXt5q0+5Y5PI0Q4a9uBRvBOo
        LavQbTe7QX1xXh+BGzzAgw==
X-Google-Smtp-Source: APiQypLQMvGNIQhG4s1tkZMxpT9DVRT4GUyEp3fBPRNGGOeKQihYNc95wXho7TdFHmK0qtz1U6kbVw==
X-Received: by 2002:a05:6808:3b7:: with SMTP id n23mr250477oie.168.1588874866696;
        Thu, 07 May 2020 11:07:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c25sm1494388otp.50.2020.05.07.11.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:07:46 -0700 (PDT)
Received: (nullmailer pid 14721 invoked by uid 1000);
        Thu, 07 May 2020 18:07:43 -0000
Date:   Thu, 7 May 2020 13:07:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/11] PCI: qcom: introduce qcom_clear_and_set_dword
Message-ID: <20200507180743.GA2255@bogus>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
 <20200430220619.3169-7-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430220619.3169-7-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 12:06:13AM +0200, Ansuel Smith wrote:
> Use qcom_clear_and_set_dword instead of use the same code many times in
> the entire driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 108 ++++++++++---------------
>  1 file changed, 41 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 921030a64bab..a4fd5baada34 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -184,6 +184,16 @@ struct qcom_pcie {
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
> +static void qcom_clear_and_set_dword(void __iomem *addr, u32 clear_mask,
> +				     u32 set_mask)
> +{
> +	u32 val = readl(addr);
> +
> +	val &= ~clear_mask;
> +	val |= set_mask;
> +	writel(val, addr);
> +}

If we wanted this kind of register accessor in the kernel, then we'd 
have common ones. We don't because it hides the possible need for 
locking on a RMW sequence.

Also, not a fix. Don't mix refactoring with fixes.

Rob
