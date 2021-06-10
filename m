Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5153A3057
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJQSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 12:18:30 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43946 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJQSa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 12:18:30 -0400
Received: by mail-ot1-f52.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso206976otu.10;
        Thu, 10 Jun 2021 09:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofEO3HsUWK07Lx2VSX5oLpVzPlgl6WHrBYoJtQCpde4=;
        b=TWAJWa4YDPbPvZGZyK7UIti/q/ynWhC+pYU+upJsO3mK8Ok2bVZYiYzKPxE+uXt084
         dMMTpguvt4wRjMIfx2rekRYaWQfUiHF3JpwAsUJWqHr1wg9vw0E00zcpPsGRzYV8zX7G
         ZXx4V/JNkpYL58UDJZFXiE87VyvPz99nNlUeXx26zvaSlnRdceptOOLWU6FugtOT8BSa
         8r6yzWndN/gQzlx8XdBxYVkdj/nJsXuHRly0wvXDH/u4c+PJZd1VwSInxYhB8tJ3RO2K
         Pawl2gQRjWomLKrcVEa5MIEQqof1hCICS2cw/GcyQwgHj1HYckw/UWyG71dF50RmOedm
         OaBA==
X-Gm-Message-State: AOAM531dcrbjCrW24miP25nD3U7Kr5aAxj+sBro2oUciQkkQvNGEEzY9
        U9KEwluEomTjtwVwJoTcsQ==
X-Google-Smtp-Source: ABdhPJwYNeXmfvs3XPVsdKQpxwAAtg9u28rarO5FRMzjqZQdJ9GfInQHmmnUSH76QTAXOaa1jtPzJw==
X-Received: by 2002:a05:6830:12d3:: with SMTP id a19mr3018565otq.107.1623341779028;
        Thu, 10 Jun 2021 09:16:19 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id b22sm158695oov.31.2021.06.10.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:16:18 -0700 (PDT)
Received: (nullmailer pid 1907491 invoked by uid 1000);
        Thu, 10 Jun 2021 16:16:15 -0000
Date:   Thu, 10 Jun 2021 11:16:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     lorenzo.pieralisi@arm.com, stefan@agner.ch,
        linux-pci@vger.kernel.org, l.stach@pengutronix.de,
        shawnguo@kernel.org, kernel@pengutronix.de,
        andrew.smirnov@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: Re: [RESEND, V5 1/2] dt-bindings: imx6q-pcie: Add "vph-supply" for
 PHY supply voltage
Message-ID: <20210610161615.GA1907422@robh.at.kernel.org>
References: <1622771269-13844-1-git-send-email-hongxing.zhu@nxp.com>
 <1622771269-13844-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622771269-13844-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 04 Jun 2021 09:47:48 +0800, Richard Zhu wrote:
> The i.MX8MQ PCIe PHY can use either a 1.8V or a 3.3V power supply.
> Add a "vph-supply" property to indicate which regulator supplies
> power for the PHY.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
