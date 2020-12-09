Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF372D48BF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 19:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgLISQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 13:16:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42146 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbgLISQa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 13:16:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id l200so2685316oig.9;
        Wed, 09 Dec 2020 10:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lJcMTcPkrpO01a5vanNh8HvkDxv8RBC31yXvSLm2o80=;
        b=Vw3/SiRaYAGUag7Zh+I20rQc6+Nckjb88nrso+FJPId4gBn8QXZ8lOfPpJA/nspZev
         jeyfIiqr068rDA8dfX2dsejbn3GP67xFiLuEXpSQVJ8/YGFmrZ4pWlsH3Zh2T6LcpZMf
         6AXRf1VZ2Y6eirUP5JMr5IF0khhwBVFoWVON6GR8UZeyPKj6g4+vJSiIUqcifoqZ9zJg
         Clx9UV7wy7nlOnh3Yvvmw0Kdj0G2BROXExMD1IRwVZQ23+BBR0dQHDpN3T+khZW/TvpX
         gVmPfIZhTwcEODouISLjErBCDZjcxYStPUnXZhbKuUhftb5Ol5Z5wsfL+wBE3cxSX+C3
         rk+g==
X-Gm-Message-State: AOAM531GTgrwkr1ZjUMBzNbCubGLiNZdqMLSMp00UCq/y5esZlDYKYe4
        +cRFCXWmSELIwgJri34uKw==
X-Google-Smtp-Source: ABdhPJwe7wnywEwUD5Ewmn/eXNVOi9weo+w3uina5FF0l726ppoajbx2RdwePcegK1yH2XkfhD+3Pg==
X-Received: by 2002:a05:6808:16:: with SMTP id u22mr2645358oic.1.1607537749399;
        Wed, 09 Dec 2020 10:15:49 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 73sm532299otv.26.2020.12.09.10.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:15:48 -0800 (PST)
Received: (nullmailer pid 705639 invoked by uid 1000);
        Wed, 09 Dec 2020 18:15:47 -0000
Date:   Wed, 9 Dec 2020 12:15:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mgross@linux.intel.com, bhelgaas@google.com,
        lakshmi.bai.raja.subramanian@intel.com,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe
 controller
Message-ID: <20201209181547.GA705595@robh.at.kernel.org>
References: <20201202073156.5187-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201202073156.5187-2-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202073156.5187-2-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 02 Dec 2020 15:31:55 +0800, Wan Ahmad Zainie wrote:
> Document DT bindings for PCIe controller found on Intel Keem Bay SoC.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/pci/intel,keembay-pcie-ep.yaml   | 68 +++++++++++++
>  .../bindings/pci/intel,keembay-pcie.yaml      | 96 +++++++++++++++++++
>  2 files changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
