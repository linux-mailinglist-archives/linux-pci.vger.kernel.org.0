Return-Path: <linux-pci+bounces-1991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182C829A6E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 13:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F80C1F25A0C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF814208A4;
	Wed, 10 Jan 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hpJGKWNC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FA17F5
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240110123121epoutp0311eba8eafe0cda6c8bafa8a3796d16bd~o-FBsN4qX1134511345epoutp03i
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 12:31:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240110123121epoutp0311eba8eafe0cda6c8bafa8a3796d16bd~o-FBsN4qX1134511345epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704889881;
	bh=NLR0Da2HJRvhPJEhT89C1fj3tvYuS2W+F5XGCPG5Fu4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=hpJGKWNCV9AWWpCE6OUHV6F61bwboqxgxHHqX5b+AppBSBZpySSukenkLUhNS8Lbv
	 no/ETAiLJDERBAIecstmgZ6Dgg9BckwmS/3lBblkXhqiaQVicc9b/0jb9MJ9aF5M/8
	 s+eY08IZykYHyZrs8ZwtX4rc7M6jLCFVq2od/Jnw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240110123120epcas5p384f0e22e8047bbe5ca0a40d4bb4ba625~o-FBM6hr60204302043epcas5p3s;
	Wed, 10 Jan 2024 12:31:20 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T96bp6nh5z4x9Pr; Wed, 10 Jan
	2024 12:31:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DE.78.09634.61E8E956; Wed, 10 Jan 2024 21:31:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240110123118epcas5p21c8034cd96a7abfc64839cfb13a9d108~o-E-D-nim1713217132epcas5p2k;
	Wed, 10 Jan 2024 12:31:18 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240110123118epsmtrp15528d2b6119785d3ee9343a00b988d10~o-E-C8-Vk0983609836epsmtrp1T;
	Wed, 10 Jan 2024 12:31:18 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-c8-659e8e160ee2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.24.07368.61E8E956; Wed, 10 Jan 2024 21:31:18 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240110123115epsmtip11b776a44777a465ea395449d2c96f3b9~o-E8hV3j41485414854epsmtip1c;
	Wed, 10 Jan 2024 12:31:15 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Shradha Todi'" <shradha.t@samsung.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>, <jingoohan1@gmail.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
	<linux@armlinux.org.uk>, <m.szyprowski@samsung.com>,
	<manivannan.sadhasivam@linaro.org>, <alim.akhtar@samsung.com>
In-Reply-To: <20240110110115.56270-2-shradha.t@samsung.com>
Subject: RE: [PATCH v3 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Date: Wed, 10 Jan 2024 18:01:14 +0530
Message-ID: <001001da43c0$e8e9a8e0$babcfaa0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK3Yhu837gawrdP2S3E1hwP53Jf7wFhoUR7AWI/r/mvApvyoA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbZRz1672998JSvRYc37rIys0gewi0k9aLjKkMzcUtEYOJcT66Qq8U
	6cs+NuY2eQjlMWDClJcMtznY0qRBGCAUioNVEJJlsmGRBbYlIGFrYMiIiMC05TLlv3N+3zk5
	3/keBCKcwkREms7MGnVKDYX5o23Xdu4I31xax0qaKmT0vbo2jL6Yo6YvL1TjtNPTitNZxct8
	unnCzaf/KL7Dp285ajH6el0/Rlfd6ObRvV87AZ27kovSdtc4To/nFvLpocHX6X+62nH6sbsJ
	pUuunXxVyNxyDyHMw9/ycKajZhxnzjVbmGZbIcaMubswZnK4ksdcuZjJlLbYAPOoOTjR/1D6
	XjWrVLFGMatL0avSdKmx1IEkxX6FTC6Rhkuj6ZcosU6pZWOp+IOJ4W+kabyNKPERpcbiHSUq
	TSYqct9eo95iZsVqvckcS7EGlcYQZYgwKbUmiy41QseaX5ZKJHtkXuHhdPVS1hJqqN+R0VfZ
	gWWBypAi4EdAMgquum9jRcCfEJKdAOZklayTeQDbZgfWyZ8AunJbeE8s1yd/RrgFJ4BnHzoA
	R6YBXCyfW1NhZDhs/866Zg8kRwBcWLShPoKQDh4sHMxBfCo/Mgb23J3l+3AA+S5cGl5awygZ
	Ckdv1nrdBCEgo+EZj79vLCCfhQPVk6gPI+Ru2HDeg3BbEsOl3xvWrIFkHOxbrV/XBMH7P7lw
	Xy4k8/3g3YI2PmeIh/YfK1AOB8AH/S04h0Xw/mkr7suFJAMvrIi4sRrOXGoEHH4FXh2uRX0S
	hNwJGx2RXNTTsGR5ksc5BbDAKuTUofCL2V/Xg7bCslOn1jfAQFfVFPgShNRsKFazoVjNhgI1
	/4edA6gNbGENJm0qa5IZpDr26H8XnqLXNoO1B78roR2M35uL6AU8AvQCSCBUoED8qJYVClTK
	Y5+xRr3CaNGwpl4g8x52GSJ6LkXv/TE6s0IaFS2JksvlUdEvyqVUkMCTd1YlJFOVZjadZQ2s
	8YmPR/iJsnj5M0e3eZyzA3umT5a95z+9abQvyXF7ptUFA2JOi/rBD7vd08EkP75WHu6MEMVt
	7gxthGNWtXnfUwmflpbPfh78AM/+pmvkl6t9Ia5AhfWAxHHHttKxvfWjfsIqHSuPyxv7W1hU
	8W35gl0zMWHPxPFDKsXiTMYzA0kZx28MJW/6sKf+r+ePiF4wH7yg1ZR9MBL2NlYnaNQcf/xa
	5nBVd1gS4n4nVZ4fWVQgS7B/fyIyzTkc0x05f+IKJs2eam0rVhwLDfqk1VzyZl5i9leXtyyO
	wqlL7Ptz8wODmFRnkdo+jk1KJsgzWv5I2Lbc5O2e6p5Vy1byfNNNqqHzre7lw06EQk1qpXQX
	YjQp/wV+zm/4eQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSnK5Y37xUg583xS0ezNvGZrGkKcNi
	xZeZ7BZ7X29lt2jo+c1qsenxNVaLjz33WC0u75rDZnF23nE2ixnn9zFZHJq6l9Gi5U8Li8Xa
	I3fZLe62dLJaXDzlavF/zw52i3/XNrJY9B6udRDyuHztIrPH+xut7B47Z91l91iwqdRj06pO
	No871/aweTy5Mp3JY/OSeo++LasYPT5vkgvgiuKySUnNySxLLdK3S+DK+HzyM3PBfPWKd6vO
	MzYwTlToYuTkkBAwkTj75ARzFyMXh5DAbkaJFy/b2SAS0hLXN05gh7CFJVb+e84OUfSMUeLL
	6XOsIAk2AV2JHYvb2EASIgJ3GSUal/8Bq2IWOMEk8eTBHoS5975PYQRp4RSwljh4/x1Yu7BA
	qMTFxnVg+1gEVCVuXpoDZHNw8ApYSkx+zQUS5hUQlDg58wkLiM0soC3R+7CVEcZetvA1M8R5
	ChI/ny4DGyki4CRx7O9SqHpxiZdHj7BPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucmG
	BYZ5qeV6xYm5xaV56XrJ+bmbGMGRrqWxg/He/H96hxiZOBgPMUpwMCuJ8Cp8npMqxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQimCwTB6dUA1Pljav5LndipQ8+T+gp
	eD9H2IZvkVpT0OPph47nSx3Pqb83rbBk6qsIs0ObNk+w1Fz0uyjvhlnkUZUQJ6PE1hV52nMq
	91nWbFgS5rjapu+l/oZFNR16u5cmxe1ck39TzO7Lw+jKlRvM5zG1f7JKPbAj/CjzpLAfT8vf
	92dP/SJ1VuzWoWwdNmkdt3nTVC64+S+Uizrz7omj4V+jR6p9r3b6X2r2qPZf/fzGCtOaf4qL
	N668p/lQMPXKs5w91a5LNu4P/hJUnub4sdl7+WyVds5FreofChpuriyaceSxSEjvrv8ugTIK
	xU05XHLJtp050tMPT55os+pUIvPsSeyLltkLXwzvFrGpE4icUrLoq4ASS3FGoqEWc1FxIgBK
	nJpwYwMAAA==
X-CMS-MailID: 20240110123118epcas5p21c8034cd96a7abfc64839cfb13a9d108
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3
References: <20240110110115.56270-1-shradha.t@samsung.com>
	<CGME20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3@epcas5p3.samsung.com>
	<20240110110115.56270-2-shradha.t@samsung.com>

Hi Shradha,

> -----Original Message-----
> From: Shradha Todi <shradha.t=40samsung.com>
> Sent: Wednesday, January 10, 2024 4:31 PM
> To: linux-clk=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-sams=
ung-
> soc=40vger.kernel.org
> Cc: mturquette=40baylibre.com; sboyd=40kernel.org; jingoohan1=40gmail.com=
;
> lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> bhelgaas=40google.com; krzysztof.kozlowski=40linaro.org;
> alim.akhtar=40samsung.com; linux=40armlinux.org.uk;
> m.szyprowski=40samsung.com; manivannan.sadhasivam=40linaro.org; Shradha
> Todi <shradha.t=40samsung.com>
> Subject: =5BPATCH v3 1/2=5D clk: Provide managed helper to get and enable=
 bulk
> clocks
>=20
> Provide a managed devm_clk_bulk* wrapper to get and enable all bulk clock=
s
> in order to simplify drivers that keeps all clocks enabled for the time o=
f driver
> operation.
>=20
> Suggested-by: Marek Szyprowski <m.szyprowski=40samsung.com>
> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> ---
>  drivers/clk/clk-devres.c =7C 41
> ++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk.h      =7C 25 ++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>=20
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c index
> 4fb4fd4b06bd..05b0ff4bc1d4 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> =40=40 -102,6 +102,7 =40=40
> EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
>  struct clk_bulk_devres =7B
>  	struct clk_bulk_data *clks;
>  	int num_clks;
> +	void (*exit)(int num_clks, const struct clk_bulk_data *clks);
>  =7D;
>=20
>  static void devm_clk_bulk_release(struct device *dev, void *res) =40=40 =
-182,6
> +183,46 =40=40 int __must_check devm_clk_bulk_get_all(struct device *dev,=
  =7D
> EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
>=20
> +static void devm_clk_bulk_release_all_enabled(struct device *dev, void
May be devm_clk_bulk_release_all_disable()

Also this is similar to already existing devm_clk_bulk_release_all(), may b=
e you can reuse this function
And add the exit() callback in devm_clk_bulk_release_all()

> +*res) =7B
> +	struct clk_bulk_devres *devres =3D res;
> +
> +	if (devres->exit)
> +		devres->exit(devres->num_clks, devres->clks);
> +
> +	clk_bulk_put_all(devres->num_clks, devres->clks); =7D
> +
> +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,

May be devm_clk_bulk_get_all_enable() is more suitable

> +				  struct clk_bulk_data **clks, int *num_clks) =7B
> +	struct clk_bulk_devres *devres;
> +	int ret;
> +
> +	devres =3D devres_alloc(devm_clk_bulk_release_all_enabled,
> +			      sizeof(*devres), GFP_KERNEL);
> +	if (=21devres)
> +		return -ENOMEM;
> +
> +	ret =3D clk_bulk_get_all(dev, &devres->clks);
> +	if (ret > 0) =7B
> +		*clks =3D devres->clks;
> +		devres->num_clks =3D ret;
> +		*num_clks =3D ret;
> +		devres_add(dev, devres);
> +	=7D else =7B
> +		devres_free(devres);
> +		return ret;
> +	=7D
> +
> +	ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
> +	if (=21ret)
> +		devres->exit =3D clk_bulk_disable_unprepare;
> +
> +	return ret;
> +=7D
> +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
> +
>  static int devm_clk_match(struct device *dev, void *res, void *data)  =
=7B
>  	struct clk **c =3D res;
> diff --git a/include/linux/clk.h b/include/linux/clk.h index
> 1ef013324237..bf3e9bee5754 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> =40=40 -438,6 +438,24 =40=40 int __must_check
> devm_clk_bulk_get_optional(struct device *dev, int num_clks,  int
> __must_check devm_clk_bulk_get_all(struct device *dev,
>  				       struct clk_bulk_data **clks);
>=20
> +/**
> + * devm_clk_bulk_get_all_enabled - managed get multiple clk consumers
> and
> + *					enable all clk
> + * =40dev: device for clock =22consumer=22
> + * =40clks: pointer to the clk_bulk_data table of consumer
> + * =40num_clks: out parameter to store the number of clk_bulk_data
> + *
> + * Returns success (0) or negative errno.
> + *
> + * This helper function allows drivers to get several clk
> + * consumers and enable all of them in one operation with management.
> + * The clks will automatically be disabled and freed when the device
> + * is unbound.
> + */
> +
> +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> +				struct clk_bulk_data **clks, int *num_clks);
> +
>  /**
>   * devm_clk_get - lookup and obtain a managed reference to a clock
> producer.
>   * =40dev: device for clock =22consumer=22
> =40=40 -960,6 +978,13 =40=40 static inline int __must_check
> devm_clk_bulk_get_all(struct device *dev,
>  	return 0;
>  =7D
>=20
> +static inline int __must_check devm_clk_bulk_get_all_enabled(struct
> device *dev,
> +				struct clk_bulk_data **clks, int *num_clks) =7B
> +
> +	return 0;
> +=7D
> +
>  static inline struct clk *devm_get_clk_from_child(struct device *dev,
>  				struct device_node *np, const char *con_id)
> =7B
> --
> 2.17.1



