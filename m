Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1B1CEFF
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 20:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfENSXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 14:23:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38425 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfENSXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 14:23:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id s19so16169025otq.5;
        Tue, 14 May 2019 11:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uEVFNvyxMrrdXPezPoRGmk6MiU2WgaWinvyiQo20ebo=;
        b=Hp9h2X2GhVUMhROlDCmRFRS9+znKuKxE/8n3cUs3WSp6HuGdROW/5O/yMFdo6uvCB1
         e0zvhudBD+Hoh08EmK6pjOdKQyNt3W3j6fmiw5/XjIvGH0sTB9Mma2o6yJc7hWT3oQaW
         Ow5UuIgY2pZ0yb6sBW3TK6ltjzJxsgsKKhFD8l/JEr0MgegY2ONZoebkna3Eel7ty2S5
         LvvCnKGLm1fNARohKbGDOSYbmOl6gXv/ttnAIFTn58Oq98Ol2EjKmKAgWmv/pFV6C2+F
         BL9A1fKRq/fLa6Jz4/By9NrKL6cfd/k4dGup4gFMp9PMzHVAML1n16pfu05ufXGkJ1+/
         DMXg==
X-Gm-Message-State: APjAAAWvQtymvRtdiNPRYo7pCvEhjOML51HkuJUBgK2zMrNV4pFP2L0S
        LecwpUaSWl49EnJqarDZSw==
X-Google-Smtp-Source: APXvYqwlNjc4Z9d0hDZMDOuLAMmFr8q/NhiLMqLvsFReOPfm8vH2RGGwBse4cw5khsnE14ShDFNY0g==
X-Received: by 2002:a9d:6259:: with SMTP id i25mr13303501otk.250.1557858222917;
        Tue, 14 May 2019 11:23:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e31sm7415983ote.61.2019.05.14.11.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:23:42 -0700 (PDT)
Date:   Tue, 14 May 2019 13:23:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH V3 26/29] PCI: Add DT binding for "reset-gpios" property
Message-ID: <20190514182340.GA32467@bogus>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
 <20190513180744.16493-27-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513180744.16493-27-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 13 May 2019 23:37:41 +0530, Manikanta Maddireddy wrote:
> Add DT binding for "reset-gpios" property which supports GPIO based PERST#
> signal.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V3: Moved to common pci binding doc
> 
> V2: Using standard "reset-gpio" property
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
