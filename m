Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9CA5838
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfIBNk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 09:40:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35533 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbfIBNiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 09:38:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id n10so3980783wmj.0;
        Mon, 02 Sep 2019 06:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=MUHGsZO7Q+UL7B/0Bo+ObMbSvRnyd9TzsXp9a78oerg=;
        b=a7YRsJH2QwgfFmUgeQ464+D0ZNBA07dqjOIxa/TQVOZw5fTX/nWZ/fIk/x+HDpWjtU
         JltamdCffLn1z9pE50tr8V6rLxfl7QvwNbqwDQ50rqedPzc4MU3XG+cg3mPtbDJc66Gf
         l7pwcbvse4R4axTJpkqlbILuWoXuieDlR45c86Cz1abl31Ysemv2R4uumaSwAx0n+LXb
         YKzOFf7FOK5A23uZnjUDRl9waiTLlihpmncG3GbamKh16g6ZJdVdHhHJUUP2geII1bKk
         B4H+Er7PrDBupBGjqX8IZ6nzBowlyEgnG8fLqGpLcJxXVUNaoRYQA1v6BTqxcJzprkGM
         kD2A==
X-Gm-Message-State: APjAAAXkcErO2nLv9vB+IuYs0bG2czCqkSw3SZqpjND63rYPJfKfkgWv
        buqn+/ySqoWWQMUC0NF7rQ==
X-Google-Smtp-Source: APXvYqyvLTbczPJL2Kgv5aZwJae8V+vC19nEZctvk8m+po+VCSqy5grfmLXTj04W+bRvfuCa0/8m2A==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr94851wmi.170.1567431531911;
        Mon, 02 Sep 2019 06:38:51 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id j18sm12521185wrr.20.2019.09.02.06.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:51 -0700 (PDT)
Message-ID: <5d6d1b6b.1c69fb81.37811.4cd5@mx.google.com>
Date:   Mon, 02 Sep 2019 14:38:50 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 2/6] dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
References: <20190828172850.19871-1-vidyas@nvidia.com> <20190828172850.19871-3-vidyas@nvidia.com>
In-Reply-To: <20190828172850.19871-3-vidyas@nvidia.com>
Content-Type: text/plain
Cc:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Aug 2019 22:58:46 +0530, Vidya Sagar wrote:
> Add optional bindings "vpcie3v3-supply" and "vpcie12v-supply" to describe
> regulators of a PCIe slot's supplies 3.3V and 12V provided the platform
> is designed to have regulator controlled slot supplies.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * None
> 
> V2:
> * None
> 
>  .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

