Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D569312704D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 23:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLSWFJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 17:05:09 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38253 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSWFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 17:05:08 -0500
Received: by mail-yw1-f68.google.com with SMTP id 10so2787824ywv.5;
        Thu, 19 Dec 2019 14:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ZLXo5NjpSRAxo1kpGOmOXM5hSzlfuVkSp439RA+RFk=;
        b=nKJyvfLPIkNgXq4Vk/HErscJQSHFoqz5/4vhCEeQFBRKYh3ZlJZ6WFhcbfsSu5qxei
         g3Ldc+yb64XScCUUVauW9iSVVzzhhjaTAqsDT/wIYbKlWBRA4Xxf9ojPJj74aAe0H44v
         q5JN7pImy1oGOP7EdWB9wPqGPPoXSbZUsQayL5tqia+tkNL9gt1E+FG+YwiZCHbyKUYQ
         g0Txe/XceSRkViY1kV23JGOTd9SLUa5vvUs1EAIjG4Rnn1jTX0kDqZwHcniFqrygbB/3
         aqNMQEPvjfw5gA+81kAMlg9hsDmI4Im/uVQMXao/gfug8NMNC2eDhlpMp7q2/1KbjU7S
         ShAw==
X-Gm-Message-State: APjAAAXRwXuqM9DlbMV37OvAVsF7wTebrJdttuOaM05aXFcIw2r7wwLa
        AAW7tDi+VFGgE9u61gCoww==
X-Google-Smtp-Source: APXvYqwGDJJUF+JP/PfFSSCbn62gaMUqUnaNPm8Ka78UNu1rFv1DVCnAhHZw9+75RosiSxzI4EHmkg==
X-Received: by 2002:a0d:c243:: with SMTP id e64mr8252091ywd.12.1576793107781;
        Thu, 19 Dec 2019 14:05:07 -0800 (PST)
Received: from localhost (ip-99-203-15-82.pools.spcsdns.net. [99.203.15.82])
        by smtp.gmail.com with ESMTPSA id h193sm2928138ywc.88.2019.12.19.14.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:05:07 -0800 (PST)
Date:   Thu, 19 Dec 2019 16:03:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add UniPhier PCIe endpoint
 controller description
Message-ID: <20191219215617.GA11666@bogus>
References: <1576116138-16501-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1576116138-16501-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576116138-16501-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 12 Dec 2019 11:02:17 +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PCIe controller implemented in UniPhier SoCs
> when configured in endpoint mode. This controller is based on
> the DesignWare PCIe core.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/pci/uniphier-pcie-ep.txt   | 47 ++++++++++++++++++++++
>  MAINTAINERS                                        |  2 +-
>  2 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie-ep.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
