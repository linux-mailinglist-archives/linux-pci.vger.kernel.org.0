Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4445AFE67A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2019 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfKOUlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 15:41:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45821 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKOUlA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 15:41:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so7200591pfn.12;
        Fri, 15 Nov 2019 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=/eNCiZb2B70OcvEG4CFJpEsh/64tl0xUputhGCMOUYk=;
        b=KEFLQjC68s5hcGa6HKaiZ36mHeZpBcRX+uss4WLCl0rPqOYZ4dh//08RCSMKEXvuE3
         j9DDSyJ5+tjD3/fi5VQiUzPpZ6+PelhIpMzTDq0xlJ5uqwNa4odNBXz17oVt7sCpDWai
         aTGOjT4INKJniDU8CLFuk8UjPBplWMDbnhaO83Uy4ctCQNgeVYq7Mbpa4tnvmSbx/ZmP
         hlLbrg8t6Xr+QQoEAMpRQsnzAabIy45HqpZ3mrX2RX+h8KVY3nKdDURlH3ICnnQaWoo0
         5NMK5qixklNzxtQgbjktf9GMjf/jvvmXj2eX/kylQht65vYStMwmFEbo1Lgcp0ww6NB9
         6r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=/eNCiZb2B70OcvEG4CFJpEsh/64tl0xUputhGCMOUYk=;
        b=EPhI+mNHJtt3Vad3yW+nxIXxfL/SDpMqDwDh0WPLTdwO2weBBgNrK7q7j/k3LNK8Xv
         WJSLtkCKUslI4SmmtUjauZPzqWzbtFgJb9SX8Emp861MsX9JL2JOwkl6e70mEG5b9H54
         D/wWiPDDs1XK+6WxJBohsDi0KzURhQC0hwP2C5SN1I5sVSHVQPxUb+WUVjXJM5W6awsZ
         fggv3GOlj7gU/tgGovdg0BwOP8tLoXwMKFk9vlhM98GByJmr+bRMrzK3iSihXckDROFZ
         9Bdp9KUukuWwa5ly3m7sLeO+/v2x3EAF1M21TnSaQVxOo+rWSObm2M8TQnl7ZKCb4P+0
         FBrQ==
X-Gm-Message-State: APjAAAVD0S9nNKx8kiT9ygfiUzDgx4ZCdq5N0lz8BWWNe6hBETvWmw57
        FCdzmqSiUxLjjYs95yrh+bU=
X-Google-Smtp-Source: APXvYqy74GmqDuG9mHumRBh3b9gvQ06iG7nb1jxhEOnmmOgripvzWoZiWV+GTyyrtTmTBC6fGimcow==
X-Received: by 2002:a63:1e1f:: with SMTP id e31mr18356918pge.303.1573850457702;
        Fri, 15 Nov 2019 12:40:57 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id b82sm11511061pfb.33.2019.11.15.12.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 12:40:56 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v7 2/3] dwc: PCI: intel: PCIe RC controller driver
Thread-Topic: [PATCH v7 2/3] dwc: PCI: intel: PCIe RC controller driver
Thread-Index: AQHVm1y/foErHfC6cU+1DW6VLv0AgqeMszGN
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Fri, 15 Nov 2019 20:40:51 +0000
Message-ID: <SL2P216MB01056231B6036941BEF71738AA700@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <cover.1573784557.git.eswara.kota@linux.intel.com>
 <99a29f5a4ce18df26bd300ac6728433ec025631b.1573784557.git.eswara.kota@linux.intel.com>
In-Reply-To: <99a29f5a4ce18df26bd300ac6728433ec025631b.1573784557.git.eswara.kota@linux.intel.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/14/19, 9:31 PM, Dilip Kota wrote:

> Add support to PCIe RC controller on Intel Gateway SoCs.
> PCIe controller is based of Synopsys DesignWare PCIe core.
>
> Intel PCIe driver requires Upconfigure support, Fast Training
> Sequence and link speed configurations. So adding the respective
> helper functions in the PCIe DesignWare framework.
> It also programs hardware autonomous speed during speed
> configuration so defining it in pci_regs.h.
>
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---

[.....]

>  drivers/pci/controller/dwc/Kconfig           |  10 +
>  drivers/pci/controller/dwc/Makefile          |   1 +
>  drivers/pci/controller/dwc/pcie-designware.c |  57 +++
>  drivers/pci/controller/dwc/pcie-designware.h |  12 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c   | 542 +++++++++++++++++++++=
++++++
>  include/uapi/linux/pci_regs.h                |   1 +
>  6 files changed, 623 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 0ba988b5b5bc..fb6d474477df 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -82,6 +82,16 @@ config PCIE_DW_PLAT_EP
>  	  order to enable device-specific features PCI_DW_PLAT_EP must be
>  	  selected.
> =20
> +config PCIE_INTEL_GW
> +	bool "Intel Gateway PCIe host controller support"
> +	depends on OF && (X86 || COMPILE_TEST)
> +	select PCIE_DW_HOST
> +	help
> +	  Say 'Y' here to enable PCIe Host controller support on Intel
> +	  Gateway SoCs.
> +	  The PCIe controller uses the DesignWare core plus Intel-specific
> +	  hardware wrappers.
> +

Please add this config alphabetical order!
So, this config should be after 'config PCI_IMX6'.
There is no reason to put this config at the first place.

>  config PCI_EXYNOS
>  	bool "Samsung Exynos PCIe controller"
>  	depends on SOC_EXYNOS5440 || COMPILE_TEST
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller=
/dwc/Makefile
> index b30336181d46..99db83cd2f35 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) +=3D pcie-designware.o
>  obj-$(CONFIG_PCIE_DW_HOST) +=3D pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) +=3D pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) +=3D pcie-designware-plat.o
> +obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o

Ditto.

Best regards,
Jingoo Han

>  obj-$(CONFIG_PCI_DRA7XX) +=3D pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) +=3D pci-exynos.o
>  obj-$(CONFIG_PCI_IMX6) +=3D pci-imx6.o
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 820488dfeaed..479e250695a0 100644

[.....]
