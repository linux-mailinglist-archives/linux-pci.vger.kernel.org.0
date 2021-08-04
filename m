Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B63E02FE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbhHDOXj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 10:23:39 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:38903 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbhHDOXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 10:23:36 -0400
Received: by mail-il1-f182.google.com with SMTP id h18so1824876ilc.5;
        Wed, 04 Aug 2021 07:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lTaA7ZYHhzmYfTmfzRRp4FRXAEfJEDOsTjIWl9+Hssc=;
        b=YLtZgc35NlAuLyosqUcsQRbPN4nZjASQjUs7COIgJGqT98Mo84zDjN9tAXrwF1GBtK
         zvuiP8J+GzcD6Ojsyo1mH5dWsLuMYsiaQ69k1W42Fy0ur/0amJyUPST+pOwsbnkDTEoI
         LdsrIM48M2hV+6slwx9OH4+okR3qBy8qpOUAhPxkfveSjLL+WAJXps7akpvH6/fGmQV3
         cgMZcPIg35OJyNRGALFcd+92M114v2/+QIrwPDRJj484p6yoVPRR3fUTYdP/6oPSeofn
         j4OCR8J+69vrXwneZ+o1w0NfdGIVaBLPrTTzNnoer/Irfo8TJeCnvMqItc6lR8NeAasf
         Zisw==
X-Gm-Message-State: AOAM531oRzASzd3fsBIBwiqST7nuwJWMOiQhKSo0uRMHoFdwh4OVqS/u
        YkypOMdVIP6QNggZcrAFMw==
X-Google-Smtp-Source: ABdhPJzw3DsMPyrOtt1yGTBwjo1oUxTt8cIFbawDLIaXsTRb7KTM34+LDbsZ+0MZzsQgAzDoMmW6QA==
X-Received: by 2002:a92:d3cb:: with SMTP id c11mr409039ilh.178.1628086997189;
        Wed, 04 Aug 2021 07:23:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g11sm1151785ilc.83.2021.08.04.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:23:16 -0700 (PDT)
Received: (nullmailer pid 1148630 invoked by uid 1000);
        Wed, 04 Aug 2021 14:23:14 -0000
Date:   Wed, 4 Aug 2021 08:23:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mauro.chehab@huawei.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH v4 2/4] dt-bindings: PCI: kirin: Convert kirin-pcie.txt
 to yaml
Message-ID: <YQqi0ke6Q7CfShcC@robh.at.kernel.org>
References: <cover.1628061310.git.mchehab+huawei@kernel.org>
 <081c179ef2e0ddf11566144cd5967b15268565b4.1628061310.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <081c179ef2e0ddf11566144cd5967b15268565b4.1628061310.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 04 Aug 2021 09:18:55 +0200, Mauro Carvalho Chehab wrote:
> Convert the file into a JSON description at the yaml format.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 86 +++++++++++++++++++
>  .../devicetree/bindings/pci/kirin-pcie.txt    | 50 -----------
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
>  MAINTAINERS                                   |  2 +-
>  4 files changed, 88 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
> 

Applied, thanks!
