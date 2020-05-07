Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5551C9910
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 20:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEGSOT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 14:14:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41591 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgEGSOS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 14:14:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id 19so6057023oiy.8;
        Thu, 07 May 2020 11:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bqvmG1HWU4qDf3HKBnBhC+AWlEauaP8o4/CF6AJISL0=;
        b=iSUXC9FtqIsaz5t/tsaDPTR3YMAKjOQOdYIxB/sUlRcaOuSAG8eIGs6buiJiEuxFw8
         SvYzxzEX55/hjfBmuDdvth3x4AwYnV1rDoRtbvHXJwyNoytTHZLDzXkAf1G2tZaHljFE
         rQ2qyhuoWc5OeXRPEuNtwG5WV8bSWlVIfAafdl1ZolXwIMLbbblB2P+Mih6hpRvLIGmE
         J0h9duhUHWG8Mk0LjbGGjDPPXyAKlj+TpDTyuUJtj4KNauGrCbSV6SCsgWkXifWR+7BY
         ocV1HC72TBNhK88kr7JXT0AW0kUwiCzoV9TLgNbHXAQo6SJYI6sdAXzNz17lJoy6+Hvn
         UWMg==
X-Gm-Message-State: AGi0PuaFC0zawbDbCiduKWFE28QweaAJ7YXjXzD/ER7M8fExMKI1r2Q7
        VfQ9qFyRmXNAdtHcIgVsFQ==
X-Google-Smtp-Source: APiQypJjqWjf+xvhTf9ElI+7SobF1c8l+Bvu1wEqEqBkg7vIj/KOJeoIu4c/pPG8DqzuQbZDurAklA==
X-Received: by 2002:aca:b2c2:: with SMTP id b185mr3192687oif.169.1588875257552;
        Thu, 07 May 2020 11:14:17 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m16sm1500117oop.40.2020.05.07.11.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:14:16 -0700 (PDT)
Received: (nullmailer pid 25817 invoked by uid 1000);
        Thu, 07 May 2020 18:14:15 -0000
Date:   Thu, 7 May 2020 13:14:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/11] devicetree: bindings: pci: add ipq8064 rev 2
 variant to qcom,pcie
Message-ID: <20200507181415.GA25718@bogus>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
 <20200430220619.3169-11-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430220619.3169-11-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  1 May 2020 00:06:17 +0200, Ansuel Smith wrote:
> Document qcom,pcie-ipq8064-v2 needed to use different phy_tx0_term_offset.
> In ipq8064 phy_tx0_term_offset is 7.
> In ipq8064 v2 other SoC it's set to 0 by default.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
