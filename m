Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1AC462A14
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 03:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhK3CDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 21:03:20 -0500
Received: from mail-oo1-f50.google.com ([209.85.161.50]:41896 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbhK3CDU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 21:03:20 -0500
Received: by mail-oo1-f50.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so6248170oos.8;
        Mon, 29 Nov 2021 18:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cWVOuJyDk0EIPnX2ni3yCckPxLDdq4381sWOYanJ9HI=;
        b=63cA3AlwILenLtvIikiBFCtXk57d/6ylxDErtXacqu7hhE0J6xp7HhBTEcwjbhmhhu
         +v3OLstGCvwcl+M4rXSF06rviLAvWnq3iPb+XF24S+49BeGxQLoulBcdk7+/B4pvpemp
         0mBmcpJjhQ+YCtn/qX9YX1VrFFK3KgKYVr9Uz8r+moKIwzQnYKYpmjPDJu60O7mpC2Ni
         53yIpXOtCy+QetVO9wvc84s/5WSj3jrmG4Gbh0SjNFXSph3GjmQ9bWn7AAaN2plWLB34
         hoGjMg3PBB4pt/7EPVmloFTN+3eoWl9QXb5956rsvldSaB0LfpW/IFgfx/EJ7l5Tlp0F
         Ywsg==
X-Gm-Message-State: AOAM533yt+DAf4nSkHZWUNOTzRGqcfLwDduPKu2k/yfB70iiKPD5U+K6
        3sNuJckPQCYzyC/JIj3RtjViNAz/kQ==
X-Google-Smtp-Source: ABdhPJz6w7iLfzRW6rEqbXqQ7zGpfNZcpt1i+uy9RaMEwTZQaASRvNzG/SySkKagEA11alG1Z7LRbw==
X-Received: by 2002:a4a:d453:: with SMTP id p19mr33635647oos.85.1638237601479;
        Mon, 29 Nov 2021 18:00:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k17sm2530743oom.6.2021.11.29.18.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:00:00 -0800 (PST)
Received: (nullmailer pid 1019499 invoked by uid 1000);
        Tue, 30 Nov 2021 01:59:59 -0000
Date:   Mon, 29 Nov 2021 19:59:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-pci@vger.kernel.org, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: pci: layerscape-pci: Add EP mode
 compatible strings for ls1028a
Message-ID: <YaWFn5dzQ1ki1HK3@robh.at.kernel.org>
References: <20211120001621.21246-1-leoyang.li@nxp.com>
 <20211120001621.21246-4-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120001621.21246-4-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 18:16:20 -0600, Li Yang wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add EP mode compatible string for ls1028a.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
