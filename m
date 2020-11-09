Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C52AC77E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 22:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgKIVnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 16:43:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35213 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbgKIVnK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 16:43:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id n11so10489947ota.2;
        Mon, 09 Nov 2020 13:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ltpQh5ImF21wdxQMcx4hhatIZQCseLdDBHAjmPsREZE=;
        b=ub1bJIqj3ZrLupotV0NfArJyPbcvuM//T4QVGimvE8Bu3wTBF1NIItbogaKeiyvlBl
         4Ek7gNPLkIxtH8Mw0NbSQ6emB/9jjqYJlqPsvaC6vhAXz4OPX9uMV7dHkt2XAxwWteHb
         Npld+KqfTuPctzP/5d6wuJniXqAr2pQr3hSwJSkd0b6E/ExwmU9KzGyimBGgi5ONPjnJ
         oRSjuw9mrV53b8cKrbax20qAPavTOeiDX1ahLDJy/SbU2lVnyYhF54qNSjOAmD6T8TKQ
         CbC54bcEMQbHqjyJgctX6loeHstWlXFdyPoF/9pvLxB6obO5IoFH2vn64uYG5kvFu7o1
         ew5g==
X-Gm-Message-State: AOAM533cwsJqPeMxTt+uklPKDO9SFPNAGW8QRa3EatyYVeykzHsNubJ9
        CW9Olwj1KmLWbVfwIj6VGg==
X-Google-Smtp-Source: ABdhPJzJk+OMncs/nwJGzz/Ipde93VWGOAbeWIgpaTl8Jn9EEmoUenYTtyyclR+cW72DmCE3v124tg==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr12625424otc.4.1604958189079;
        Mon, 09 Nov 2020 13:43:09 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l8sm1315122oof.2.2020.11.09.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:43:08 -0800 (PST)
Received: (nullmailer pid 1807762 invoked by uid 1000);
        Mon, 09 Nov 2020 21:43:07 -0000
Date:   Mon, 9 Nov 2020 15:43:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Joseph <tjoseph@cadence.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Make "cdns,max-outbound-regions"
 optional property
Message-ID: <20201109214307.GA1807710@bogus>
References: <20201106151107.3987-1-kishon@ti.com>
 <20201106151107.3987-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106151107.3987-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 06 Nov 2020 20:41:06 +0530, Kishon Vijay Abraham I wrote:
> Make "cdns,max-outbound-regions" optional property with the default
> being 32.
> 
> Link: http://lore.kernel.org/r/20201105165331.GA55814@bogus
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml    | 3 ---
>  Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml | 2 --
>  2 files changed, 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
