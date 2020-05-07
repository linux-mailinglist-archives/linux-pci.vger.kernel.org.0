Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83A21C9B63
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 21:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGTt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 15:49:58 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:38115 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgEGTt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 15:49:58 -0400
Received: by mail-oo1-f65.google.com with SMTP id i9so1624747ool.5
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2020 12:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nRbJvUjtOQYxHS3E/kImldssq/IX6XgU7YxDrkb38sI=;
        b=IeSbu8Rrse6u8p69MF+L0P5NsKlzwg6CTt1PVzn6JxcICa6AGwf2ldqNSt5JSWntzg
         CsU0uiBYDm/wkTxutWucrkgp12BhERhLFHCFJ6PwiAW7pgm2r8dvgGr25rPicOd7W22V
         3QgYY+pJUbZMOTOPJUuDxvtXOl3m8+RdD1WMgY0+YJRqTkETll6t+H2sXrhF4DL/XGF/
         pe4bwnaaSPBkT1AjZNQtj8GqiEdu6pUnzn19eF0mW9Dd0izTp4OUUeUT4LhbchWpm07v
         +rte2TF2Ax6bSKzX3WIdaSvO3/YHmcQP1bhRFPirDGJxacznx+/fDBljnFxfy3fWhMXi
         Zcvw==
X-Gm-Message-State: AGi0Pua3RCBbhBVUU2xYxk8DwmprlTsYGBMnfP/zeEef5GfCWA+nDFbk
        zbGVKr9nX+WBPKRJMI2XlK6GOyo=
X-Google-Smtp-Source: APiQypLminlIoJOgAHszLEc6rAggdU0dTBQZ5+jwI02hRgxfRwh3tXf8bVSKBeGZAZwZ4mIOApVJ+Q==
X-Received: by 2002:a4a:ba95:: with SMTP id d21mr13215307oop.19.1588880997572;
        Thu, 07 May 2020 12:49:57 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e63sm1581183ote.41.2020.05.07.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:49:57 -0700 (PDT)
Received: (nullmailer pid 3114 invoked by uid 1000);
        Thu, 07 May 2020 19:49:56 -0000
Date:   Thu, 7 May 2020 14:49:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 4/5] PCI: pci-bridge-emul: Update for PCIe 5.0 r1.0
Message-ID: <20200507194955.GA2999@bogus>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
 <20200414203005.5166-5-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414203005.5166-5-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 14 Apr 2020 16:30:04 -0400, Jon Derrick wrote:
> Add missing bits from PCIe 4.0 and updates for PCIe 5.0 r1.0.
> 
> PCIe 4.0:
> Device Status bit 6 - W1C - Emergency Power Reduction Detected
> Link Control bits 15:14 - RW - DRS Signaling Control
> Slot Control bit 13 - RW - Auto Slow Power Limit Disable
> 
> PCIe 5.0:
> Slot Control bit 14 - RW - In-Band PD Disable
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
