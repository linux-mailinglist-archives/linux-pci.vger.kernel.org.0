Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FA930FB92
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 19:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbhBDScs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 13:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239153AbhBDSaq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 13:30:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13D1B64E06;
        Thu,  4 Feb 2021 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612463391;
        bh=m2ULECe/5nShjpaNukVPB1Kg9k0QQfSi+2ZmqBBEpGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/LNBdO3xd+g9w7/5qjfXOSTtr4mSJ9IrEz1BxVvwHFiiel3fILTMyxF534RzQQ6e
         dWNmW4YGkhvR3f0qNjS1F1cWrRBMnsLyW1vNcoqBVmXGn6etQ5nHpKlRcWNHvDfY3I
         18fpGaTjYYafIzHvYgkqDlZdUYjXqHZqYDYrE8B3KTAurSebytxHkx/+7SfOJmKxtv
         89V+vfbFUaYNvT3t1SVFjp//aaornWIug+AH20j3apiqMBiyXwAB76RYE8V6Ack1pN
         4KVJeJiu3hHE7/lDBCLzXRh7+wGLvZ/Xw32uIGZaMFElJNBnci1ddtEY22poxwjSte
         2KS29439QNy+g==
Date:   Thu, 4 Feb 2021 19:29:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <20210204192939.0daaec74@coco.lan>
In-Reply-To: <20210204172945.GA662023@robh.at.kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
        <706e684f571e142362d7be74eb1dcee2c8558052.1612271903.git.mchehab+huawei@kernel.org>
        <1612287895.001149.3887347.nullmailer@robh.at.kernel.org>
        <20210203074900.6d581153@coco.lan>
        <20210204172945.GA662023@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Thu, 4 Feb 2021 11:29:45 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Wed, Feb 03, 2021 at 07:49:00AM +0100, Mauro Carvalho Chehab wrote:
> > Hi Rob,
> > 
> > Em Tue, 02 Feb 2021 11:44:54 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >   
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: properties:snps,enable-cdm-check: 'oneOf' conditional failed, one must be fixed:
> > > 	'type' is a required property
> > > 	Additional properties are not allowed ('$ref' was unexpected)
> > > 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: properties:snps,enable-cdm-check: 'oneOf' conditional failed, one must be fixed:
> > > 		'enum' is a required property
> > > 		'const' is a required property
> > > 	'/schemas/types.yaml#definitions/flag' does not match 'types.yaml#/definitions/'  
> 
> You need a '/' between '#' and 'definitions'.

ah, OK. Will add it at the next version.
 
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: ignoring, error in schema: properties: snps,enable-cdm-check
> > > warning: no schema found in file: ./Documentation/devicetree/bindings/pci/snps,pcie.yaml
> > > 
> > > See https://patchwork.ozlabs.org/patch/1434686
> > > 
> > > This check can fail if there are any dependencies. The base for a patch
> > > series is generally the most recent rc1.
> > > 
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > date:
> > > 
> > > pip3 install dtschema --upgrade
> > > 
> > > Please check and re-submit.  
> > 
> > I've no idea why the bot is hitting those. My tree is based on
> > staging-testing[1], as I need the regulator patches merged there.
> > Such tree is based on v5.11-rc5.
> > 
> > There, dt_binding_check doesn't get any warnings on this schema:
> > 
> > $ pip3 install dtschema --upgrade --user
> > Requirement already up-to-date: dtschema in /home/mchehab/.local/lib/python3.9/site-packages (2020.12)  
> 
> This particular check is in master, but not yet a release on pypi. I'll 
> be tagging a release soon.
> 
> I've got this problem that adding new meta-schema checks like this one 
> requires fixing up all the existing in tree schemas first. So I give 
> some amount of time before adding them to a tagged release. However, I 
> want to start testing new schemas right away. I haven't come up with a 
> better solution short of importing the meta-schema into the kernel tree 
> or separately versioning them.

IMO, having the meta-schema inside the Kernel tree would be better...

It took me some time to discover that some problems I had with a past
version of this patch series were due to something outside the
Kernel tree, at local/lib/python3.9/site-packages.

Thanks,
Mauro
