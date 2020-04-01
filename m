Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE319ADA9
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbgDAOSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 10:18:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44636 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732823AbgDAOSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 10:18:43 -0400
Received: by mail-io1-f65.google.com with SMTP id r25so13994801ioc.11;
        Wed, 01 Apr 2020 07:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DrAUNTNOb+nS86WKDNkg7IGqQKQheDQgfBvXH6+K3YY=;
        b=fMaQLhc7vjvK44eFNORxvMeUmaOzz07bDvKu3KQ2p3SPqgsQti4Kd9AtivNa1cUvqh
         0lAosbw397LNb/McU5xV1Hd1netW7/AXVXemnXoDyUOsGgrtI9WqYOQEmu9P+KsmRU/H
         g6pccF3S8PD9nCh/U5UQIN6foq6dlDEl8ojuvS3tpHe0NXO1BdZgfhdcyqP91Tie5QIw
         oJLIY5c8FZ+1Q+6Pw5plKtUbCBo2P46PeaXdu4EMqKfxnTYFy+KSuuFRNX+O6PVLi4ZN
         /ISyaajD0Cg6bXhbXNa0czm9zs+ad1TCPxeySEHQuigsrQlRNyXbMWkWLJagz7NuCxZ6
         ybeg==
X-Gm-Message-State: ANhLgQ0TkLdO+iyH8SQbhKEb8p97JIHqkCW3Y+M1SurNR9JUPRrWTOiX
        4khwcGX7B/dZsYBOQRpB2RF0c2Y=
X-Google-Smtp-Source: ADFU+vtTwR3SB801fBjpsX0NGxMyX9AE4SJJQgaUk8UNcP2AQfCZmaqz6P0qia4Kb4WvYiBEVO7O0g==
X-Received: by 2002:a6b:db01:: with SMTP id t1mr20172381ioc.150.1585750722085;
        Wed, 01 Apr 2020 07:18:42 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x10sm742190ili.88.2020.04.01.07.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 07:18:41 -0700 (PDT)
Received: (nullmailer pid 24537 invoked by uid 1000);
        Wed, 01 Apr 2020 14:18:38 -0000
Date:   Wed, 1 Apr 2020 08:18:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: Document Loongson PCI Host Controller
Message-ID: <20200401141838.GA7686@bogus>
References: <20200401030658.1174045-1-jiaxun.yang@flygoat.com>
 <20200401030658.1174045-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401030658.1174045-4-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed,  1 Apr 2020 11:06:47 +0800, Jiaxun Yang wrote:
> 
> PCI host controller found on Loongson PCHs and SoCs.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../devicetree/bindings/pci/loongson.yaml     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/loongson.example.dt.yaml: pcie@40000000: ranges: [[33554432, 0, 1073741824, 0, 1073741824, 0, 1073741824]] is too short

See https://patchwork.ozlabs.org/patch/1265000

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
