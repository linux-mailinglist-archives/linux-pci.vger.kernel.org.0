Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7C1C9B82
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 22:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgEGUAq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 16:00:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37175 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGUAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 16:00:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id r25so6355644oij.4
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2020 13:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cPMkWHFNJRTdlAUVXNLhn0xNq3DdioJOL4BErWRV0OY=;
        b=XUYaoliH7l5oonecoSBeEYyH0GshSQU0wzkG0Y2e4YV1M2mUAvaQcnUuC0B9vLM9vo
         l5FqIi8sUiLx0NZslNbvk50sNYPwzsTlCj2DAG7YHOzPoxtBAa5M52XlKes+ORbU/pvL
         ih7c4ovGt6KFvY1SweCKMrnVOg60cBnoemOCUV8zdhnE9wbRvYwm6L4WRzbrAKR9cqWR
         9Q/fTCeOoqB2yKhHU2uf1GSAMIlR/3iUfeLzkEIWFgHviWOhoBpXYi0Y/CRQaX7lapxj
         HPheMp0/wRX/tEJXn+TwCDUNFo6l6Yq881m4eHluh/rG3/i1H4/iXs8JOZiRFM0RleX5
         BIEA==
X-Gm-Message-State: AGi0Pub7NqPdhmBvpOsNa5eoFdbnjMQfJN4nnE8za+pMf8JvvwXravOi
        TBOQGLmKMuio5Eq9KoRm37UG73E=
X-Google-Smtp-Source: APiQypLa4puzyM/6aIhmkofGJKFqUoEuO5ghtVNVsZuZTsnuqImfcxj6o0nfQnpImmpzNzMzkUO/jQ==
X-Received: by 2002:aca:4f4b:: with SMTP id d72mr7793899oib.73.1588881643493;
        Thu, 07 May 2020 13:00:43 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l2sm1622180oib.58.2020.05.07.13.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:00:43 -0700 (PDT)
Received: (nullmailer pid 20926 invoked by uid 1000);
        Thu, 07 May 2020 20:00:42 -0000
Date:   Thu, 7 May 2020 15:00:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 5/5] PCI: pci-bridge-emul: Eliminate the 'reserved' member
Message-ID: <20200507200042.GA20858@bogus>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
 <20200414203005.5166-6-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414203005.5166-6-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 14 Apr 2020 16:30:05 -0400, Jon Derrick wrote:
> Per PCIe 5.0 r1.0, Terms and Acronyms, Page 80:
> 
>   Reserved register fields must be read only and must return 0 (all 0's
>   for multi-bit fields) when read. Reserved encodings for register and
>   packet fields must not be used. Any implementation dependence on a
>   Reserved field value or encoding will result in an implementation that
>   is not PCI Express-compliant.
> 
> This patch ensures reads will return 0 for any bit not in the Read-Only,
> Read-Write, or Write-1-to-Clear bitmasks.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
