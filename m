Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B862F228F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jan 2021 23:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbhAKWTc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 17:19:32 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46343 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbhAKWTb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 17:19:31 -0500
Received: by mail-oi1-f172.google.com with SMTP id q205so222466oig.13;
        Mon, 11 Jan 2021 14:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+tmV/HBE7uvTKOaiU4bCpEVibry1LGggSkZA4twfVk=;
        b=is7zgTdDcFekY6QQWslMKxT+mUb4QawNi11+JtBG1y5zuGrBqGTge65YinVnCAm6ed
         l3o4zd4vCLMy6vADrBAMYQnzLgs9nC7dvldKbZcxS3fjtgAZKS7SHnp2KBeW0m2krj4S
         HJ8xOTxg98GpoVSqDAIeEXlWVSipxImaWmA0n2svTZGlFz2LklX12wSqiqai0oleWw1j
         xZn3Z1lJyMwxahsW1HYLu+q+gDIPiEasWPj4fLvjKtSy43XqKhZ+yh2iQV4bA9+55nwM
         6Y4EMe1wpnbssA1wakNmp8Z5a8VfpJ7DWB/S97HUayzSk7bKX9AvbXGfn6csBw2FWa3/
         xSnQ==
X-Gm-Message-State: AOAM531Iqb0eRk47CMJA0nHjx+H2QW1x3XlXvD9Nrb5lGGV9HHyT2WVE
        56uRsmKTDhT5BC2Edq7Ktg==
X-Google-Smtp-Source: ABdhPJx6w+uHHGH/dYGvw2E1r1efDZ2c8whHnqNdln7J+fJUx/JnpHJRNKK6nctuMwXsLFFuEMvurw==
X-Received: by 2002:aca:4dc3:: with SMTP id a186mr551653oib.107.1610403530201;
        Mon, 11 Jan 2021 14:18:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m15sm235364otl.11.2021.01.11.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 14:18:49 -0800 (PST)
Received: (nullmailer pid 3158498 invoked by uid 1000);
        Mon, 11 Jan 2021 22:18:48 -0000
Date:   Mon, 11 Jan 2021 16:18:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hongtao Wu <wuht06@gmail.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        devicetree@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC
 host controller
Message-ID: <20210111221848.GA3158447@robh.at.kernel.org>
References: <1609409905-30721-1-git-send-email-wuht06@gmail.com>
 <1609409905-30721-2-git-send-email-wuht06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609409905-30721-2-git-send-email-wuht06@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 31 Dec 2020 18:18:24 +0800, Hongtao Wu wrote:
> From: Hongtao Wu <billows.wu@unisoc.com>
> 
> This series adds PCIe bindings for Unisoc SoCs.
> This controller is based on DesignWare PCIe IP.
> 
> Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> ---
>  .../devicetree/bindings/pci/sprd-pcie.yaml         | 93 ++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
