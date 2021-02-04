Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E9330F9C1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 18:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbhBDRbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 12:31:53 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44648 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbhBDRab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 12:30:31 -0500
Received: by mail-ot1-f44.google.com with SMTP id e70so4132402ote.11;
        Thu, 04 Feb 2021 09:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VABDqQO4SCCxw9n6VdMjP3tpI9MOBd0XV0ilXTl4TqU=;
        b=bXZsNUSAr9FCbeJcIlPQ3E82Ruq35nNAKUkkToEQlsWSGZmyEy24aI6FZXVfkZmY+G
         TF64rW4JYqJAajQypMzpzuxFvGkH4UakP7wEiHaKO7fQ+LPvUFbBO10X2nVwuDFt9jDU
         WpWAUdKvKSk2cJL1POhx0EL5NA+qJcCkdxz389/pT9YODDrZXxM2r9HMeXiwPaF9cRh3
         HhdM7swoTdodw0GT3qbA0Gcs9fU6TyT0fuvqVJSxRa7kiM1Q00vKUKCQRmtFjwe+nDfp
         xhgZPRp1tT+Hc2oyZ7fz/6ZhMb/FRyzu2e5MyxixLIia+jHSg27SFf2bcn00RLu4Aayd
         OSiw==
X-Gm-Message-State: AOAM532L9rSKQC/tT7al+O6vDAOpNpIJ+0wGtsDOismZW9B3mOXzT7cF
        gZzIrfwKSvohs7mLbRi3qA==
X-Google-Smtp-Source: ABdhPJyRucRa6WFuTvsk3abTvCXMHWztBy5ONKR24Bi/EstX7fiI57+Du8n2gQUyyz1NuIk23MVq1Q==
X-Received: by 2002:a9d:1c9a:: with SMTP id l26mr331207ota.316.1612459788720;
        Thu, 04 Feb 2021 09:29:48 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z10sm1238418otk.8.2021.02.04.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 09:29:47 -0800 (PST)
Received: (nullmailer pid 682797 invoked by uid 1000);
        Thu, 04 Feb 2021 17:29:45 -0000
Date:   Thu, 4 Feb 2021 11:29:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Andy Gross <agross@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-samsung-soc@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@axis.com, Richard Zhu <hongxing.zhu@nxp.com>,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pci@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        linux-tegra@vger.kernel.org, Jonathan Chocron <jonnyc@amazon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 01/13] doc: bindings: pci: designware-pcie.txt: convert
 it to yaml
Message-ID: <20210204172945.GA662023@robh.at.kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
 <706e684f571e142362d7be74eb1dcee2c8558052.1612271903.git.mchehab+huawei@kernel.org>
 <1612287895.001149.3887347.nullmailer@robh.at.kernel.org>
 <20210203074900.6d581153@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203074900.6d581153@coco.lan>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 07:49:00AM +0100, Mauro Carvalho Chehab wrote:
> Hi Rob,
> 
> Em Tue, 02 Feb 2021 11:44:54 -0600
> Rob Herring <robh@kernel.org> escreveu:
> 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: properties:snps,enable-cdm-check: 'oneOf' conditional failed, one must be fixed:
> > 	'type' is a required property
> > 	Additional properties are not allowed ('$ref' was unexpected)
> > 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: properties:snps,enable-cdm-check: 'oneOf' conditional failed, one must be fixed:
> > 		'enum' is a required property
> > 		'const' is a required property
> > 	'/schemas/types.yaml#definitions/flag' does not match 'types.yaml#/definitions/'

You need a '/' between '#' and 'definitions'.


> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: ignoring, error in schema: properties: snps,enable-cdm-check
> > warning: no schema found in file: ./Documentation/devicetree/bindings/pci/snps,pcie.yaml
> > 
> > See https://patchwork.ozlabs.org/patch/1434686
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> 
> I've no idea why the bot is hitting those. My tree is based on
> staging-testing[1], as I need the regulator patches merged there.
> Such tree is based on v5.11-rc5.
> 
> There, dt_binding_check doesn't get any warnings on this schema:
> 
> $ pip3 install dtschema --upgrade --user
> Requirement already up-to-date: dtschema in /home/mchehab/.local/lib/python3.9/site-packages (2020.12)

This particular check is in master, but not yet a release on pypi. I'll 
be tagging a release soon.

I've got this problem that adding new meta-schema checks like this one 
requires fixing up all the existing in tree schemas first. So I give 
some amount of time before adding them to a tagged release. However, I 
want to start testing new schemas right away. I haven't come up with a 
better solution short of importing the meta-schema into the kernel tree 
or separately versioning them.

Rob
