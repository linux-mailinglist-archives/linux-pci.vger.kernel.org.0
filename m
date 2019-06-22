Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240504F3D9
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 07:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfFVF04 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jun 2019 01:26:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38970 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfFVF04 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jun 2019 01:26:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so4611585pfe.6;
        Fri, 21 Jun 2019 22:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=sZRv/LGTOOe6faTsydAViDQ1bUDA3iC8uWlW5RBxb6c=;
        b=TZ4LSzTa16KC9/e+viKoUd3imXJ1pD/yBNnq5o1E+qoOUgO076Lt8bRUg2ZawwL4/+
         SxCk1s2dvBjMmigN+QgvNQTeeTMFoon+W6vbDmXa9RjYkHyDFsu6VgMxPiDceMLHlO2W
         Rdy41rG8BWbTHkWIi0Bh0dRC5c3+6vk0/T8vmLFTFVgygydzPNm92yC+X3wCo/gto90W
         oag0DhWywOi2ZqEMw5Tn4lOQFyVVAN5TdpueK/gCKxNtjm9vlSo68wTTIHGJvMGANtRg
         7xiYknlaj5DvOyxeYoHSC9LxzLnXoTHyfGga/6mgjxl88Jy8mK0NA9zfdWUk0bNhEW1M
         8h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=sZRv/LGTOOe6faTsydAViDQ1bUDA3iC8uWlW5RBxb6c=;
        b=RqUl7uS/zkowKLnYiyrPsH0roSJ4NBZvQtyNVXLd3Gp90moxM3WUs16hSc5ABdl0v3
         n5+YVd4zICAAtW8T7FMMgk+rk6NOdx/4TkHQI6hA+KH5LfD4fKiHaVfoiV+mymODjt74
         i/uyqaethTFjduCH5qIQD8uI3bv3xAAJXLJ78bTF0bPQLT8xNH+0+ITGGbaqRlUnSov1
         eOluc7mVXumKIA458rhCfobXPiYuVJen6SnRnHDpDR0qKWabl6fk5qdDHYeKOaeEhGB9
         EIia14SFmaq91qiROiPsMACA+yqQTni6eeT+Qci2tq+/QN2gJrAosQM/0RIu/3HW4KVL
         8hrA==
X-Gm-Message-State: APjAAAU95Ga/B+DBn6epfHziYGJpGiz4LDmtuun/rMiw5s7EgmghCxHT
        ByS2dyL9xLFsCa8ovCvI/w4=
X-Google-Smtp-Source: APXvYqwhL0puArWz+Be/LkkHlaM8fRnUEobz7A4LCH1hwBouqeqhcIaOxqotozGxHd0WWonkbBHE1g==
X-Received: by 2002:a17:90a:af8b:: with SMTP id w11mr11158769pjq.135.1561181215708;
        Fri, 21 Jun 2019 22:26:55 -0700 (PDT)
Received: from PSXP216MB0662.KORP216.PROD.OUTLOOK.COM ([40.100.44.181])
        by smtp.gmail.com with ESMTPSA id f2sm3735439pgs.83.2019.06.21.22.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 22:26:54 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH V6 2/3] PCI: dwc: Cleanup DBI read and write APIs
Thread-Topic: [PATCH V6 2/3] PCI: dwc: Cleanup DBI read and write APIs
Thread-Index: AQHVKCHtRnCtljKhvUCAapB/SWoPlqanJefh
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sat, 22 Jun 2019 05:26:49 +0000
Message-ID: <PSXP216MB0662399C169A6D944E7C6A8FAAE60@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
References: <20190621111000.23216-1-vidyas@nvidia.com>
 <20190621111000.23216-2-vidyas@nvidia.com>
In-Reply-To: <20190621111000.23216-2-vidyas@nvidia.com>
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

On 6/21/19, 8:10 PM, Vidya Sagar wrote:
>=20
> Cleanup DBI read and write APIs by removing "__" (underscore) from their
> names as there are no no-underscore versions and the underscore versions
> are already doing what no-underscore versions typically do. It also remov=
es
> passing dbi/dbi2 base address as one of the arguments as the same can be
> derived with in read and write APIs.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes from v5:
> * Removed passing base address as one of the arguments as the same can be=
 derived within
>   the API itself.
> * Modified ATU read/write APIs to call dw_pcie_{write/read}() API

Unlike previous patches (v1~v5), you modified ATU read/write APIs from v6.
Why do you change ATU read/write APIs to call dw_pcie_{write/read}() API???
It is not clean-up, but function change. Please add the reason to the commi=
t message.

Best regards,
Jingoo Han

>
> Changes from v4:
> * This is a new patch in this series
>
>  drivers/pci/controller/dwc/pcie-designware.c | 28 ++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h | 43 ++++++++++++--------
>  2 files changed, 37 insertions(+), 34 deletions(-)

.....

>  static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 =
val)
>  {
> -	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
> +	int ret;
> +
> +	ret =3D dw_pcie_write(pci->atu_base + reg, 0x4, val);
> +	if (ret)
> +		dev_err(pci->dev, "write ATU address failed\n");
>  }
> =20
>  static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
> +	int ret;
> +	u32 val;
> +
> +	ret =3D dw_pcie_read(pci->atu_base + reg, 0x4, &val);
> +	if (ret)
> +		dev_err(pci->dev, "Read ATU address failed\n");
> +
> +	return val;
>  }
> =20
>  static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
> --=20
> 2.17.1

