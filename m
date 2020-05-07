Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8571C9B5C
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGTss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 15:48:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35490 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgEGTsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 15:48:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id o7so6344557oif.2
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2020 12:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VTzeMzkubnP7lJof7ufLefecCvJ2H8zD2SDSTrRAXJw=;
        b=tGaQQQXUo7c8k5k0LqB3dE9a+FEnXcQ5sjv9kxMGEB3k0RQ6ra+ZxNrH5tSTRHUb+6
         nNRfHlabzhUO2QQdgwX4VQtLzQtnuBs9ilCHoASYQ7enNZOB0R1ceycAtwHHd5FXO3aC
         WOZiDKsifwfD+pmtXJWc8+tMM5L+d0xSE4FiMIV3cFQ41D2UxeNNGcQjqF+v+7Fmm2m5
         MYbH8llo7uMUwZg6qdbaH4YkYO1OHfPk0x3McMhD5UHYVMXbE2CQevpR4g2QPVDSXjdq
         pQEGIPqdDJmdxrvfEOib5vSksxFf1Wdw0DjsnZFi7uAHl4QKnCRN1Z0hxL23dIaonWU4
         n7Og==
X-Gm-Message-State: AGi0PubLKinriMfyCx7l3BCm4jsVX1cYOFYccsvudBxs5mmu3mrhi+R6
        oJLu1csectu7uELUCPrQRQ==
X-Google-Smtp-Source: APiQypKy81GoWYtXNedAmc7LIdt7XVQXlaoCDdUtJwcTsyi1nONEa/5lfukUfKBzQpyD3l9gyb9r6w==
X-Received: by 2002:aca:ed13:: with SMTP id l19mr7577442oih.132.1588880926789;
        Thu, 07 May 2020 12:48:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h12sm1579994oou.43.2020.05.07.12.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:48:46 -0700 (PDT)
Received: (nullmailer pid 701 invoked by uid 1000);
        Thu, 07 May 2020 19:48:45 -0000
Date:   Thu, 7 May 2020 14:48:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/5] PCI: pci-bridge-emul: Fix Root Cap/Status comment
Message-ID: <20200507194845.GA628@bogus>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
 <20200414203005.5166-3-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414203005.5166-3-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 14 Apr 2020 16:30:02 -0400, Jon Derrick wrote:
> The upper 16-bits of Root Control contain the Root Capabilities
> register. The code instead describes the Root Status register in the
> upper 16-bits, although it uses the correct bit definition for Root
> Capabilities, and for Root Status in the next definition.
> 
> Fix this comment and add a comment describing the Root Status register.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
