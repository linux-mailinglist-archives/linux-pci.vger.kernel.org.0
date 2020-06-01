Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00A61EB0B7
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 23:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgFAVKR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 17:10:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39981 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgFAVKR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 17:10:17 -0400
Received: by mail-io1-f65.google.com with SMTP id q8so8495236iow.7;
        Mon, 01 Jun 2020 14:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWFsJ8KquEamPSHLBCsWKX7Wk2ZEpcA0iDByLeFaMOk=;
        b=ZvC2OsA7VSTQmEXAXhxPuegfnqu0bP3fb6w4bUGpQbFexPIEw4FLnEUu2EKPT4ovZ3
         cnq38qIgBYtbsbzYOodqeFPdD7yX4xBMN6g3Xj52+TSG5jMD+e4kny1CNz/845Y+fHva
         14DVsMTOsvNTW4/u3xVSOl5+ZKb1WsYQZMuaAtsK1xZfmk7GDmb3FQB0jeaUUEOToVKY
         2FAYpi9MuHcfzKujnsrcgeq3hW21qora9sUrDSsde/n4ozP1jKtjvz/OqEL8UTI2OrDV
         AIbM4K0MQCxED3e4ZcqIupG34ht8Arpnrt6aN2My5T8dJTLiCfmHm6iRYSSep5uW5MpV
         Xe8Q==
X-Gm-Message-State: AOAM531RLAqrprQq8fpyocRIIOne1/9tA65gKcAbNycn6pLXaGhRXPOB
        bSCglSBnXHK4mkbYTPpihw==
X-Google-Smtp-Source: ABdhPJzmCg/sHwePu42Cw+EiO+dOJNrVLw/0YD3MZLKZeR5d6kmgwS0LnOT6i5dVqu5Fl2O7AEvdgw==
X-Received: by 2002:a02:3f0f:: with SMTP id d15mr21521006jaa.138.1591045816050;
        Mon, 01 Jun 2020 14:10:16 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t9sm333655ilg.74.2020.06.01.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:10:15 -0700 (PDT)
Received: (nullmailer pid 1502746 invoked by uid 1000);
        Mon, 01 Jun 2020 21:10:13 -0000
Date:   Mon, 1 Jun 2020 15:10:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 10/10] PCI: qcom: Add Force GEN1 support
Message-ID: <20200601211013.GA1502690@bogus>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
 <20200514200712.12232-11-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514200712.12232-11-ansuelsmth@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 May 2020 22:07:11 +0200, Ansuel Smith wrote:
> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Add Force GEN1 support needed in some ipq8064 board that needs to limit
> some PCIe line to gen1 for some hardware limitation. This is set by the
> max-link-speed binding and needed by some soc based on ipq8064. (for
> example Netgear R7800 router)
> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
