Return-Path: <linux-pci+bounces-44367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9360D0A8A2
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 15:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 805D13015128
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C814B338F45;
	Fri,  9 Jan 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OP7K5wzY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DxoGpER6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74378306486
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967424; cv=none; b=fU6hpXc21GCsxBSLK8W9Suw6TjeLm3eV+vX4Q56meSsv/gCMxhbMrQ/kks00TKTokQ5WK93Yym9ZIEdu1lS2CZDsSDEr/vaGrDQUClxcn/WitqlT5iTczQkajHIs5xDSLjMfsNiIIrSp6BTGVvh+I+v+Yvc4eW/nmYRiB2AuBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967424; c=relaxed/simple;
	bh=RdtMykOjmEtDG9g2kE/0xnXGya/GK8cV0nOc7GKalLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM+zS82GiwmeflmholU/lBRyy1s4r4vmUyGOq7YWOfJpfaBgu+XrgWVHbV32n9X2nYCGy7b3NqZ9BUwVvFqx9LftqnGZibEzLWZH8ij7z6x3riDCdpwqSqHTKSzKb0iBC5mYGKrvSW/05eIpjQsLHQ0Zcj2cpnSFDUVwqjQJFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OP7K5wzY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DxoGpER6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099LYD53324821
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 14:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GQs+SI3tCjQDH71MvlNczL4V
	y/mRHLL8bORmki3/saY=; b=OP7K5wzYi6pRQjj/xiJ6j0JPK4OapKnfj/H+miEd
	RgoNbXsUBJsDoIvX4uPBSrl7lU4l7rsnDQa/jYwWlY5LAUbe9yNn/x/lcucOPc4T
	CYWZJo0sVX8FDQ2lessV3P9uUoZjkuphYkZimk2zPO5Wt1F+1KZ68KMsTzU9SO3k
	Y5UJXL86UQIj571/qQ72weDV9LDBQqFwFONwPSJCebUwGw7/onuw9AXKYqsx0alN
	p257LKp64ycY2BFwIXg5i1m4AhIcmYw7kqjvaOGjC/PeYSD4+Fw67AGCzmCMteTZ
	v91N2XRnc+vEj8Qkfx/f1FxDEpl2egWmZUj11WFfeEr+xg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6j15s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 14:03:42 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-45074787a6dso7949067b6e.0
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767967422; x=1768572222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQs+SI3tCjQDH71MvlNczL4Vy/mRHLL8bORmki3/saY=;
        b=DxoGpER6lHD82/3h9eR50Jmspi7zsgRzzBIzHcDlhlPRlCFkIluzQSOs9CvjukcZpT
         TvXXjHAz09HnUtOjjbMQNINE50/OFu/4rAdCCaMdTHKrUYLzySb3vgh1TflGf9fwGlDN
         rJYuyXbCvS41WhXL1vxiOSvve484XjaYKd4c1gTzw1NApDHC5Fo0tdjahA/km7DRimho
         2sdJxJD1ib12D7NNbAEQpeaJ8f0eYL2Z5cJSAQUa9sPF1gT97VXWwz10OIkWs3Fs2lWB
         LoSEoEgNEtE8ICOIgCHAtAP5sJqJZS3Z4Sf8d2K18PsXPKOdBjmHt68B9xY7YLaIFTPZ
         f4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767967422; x=1768572222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQs+SI3tCjQDH71MvlNczL4Vy/mRHLL8bORmki3/saY=;
        b=qhML2CDiMGzozcUKa4p6Eu7UjdTG5bPNGzcCbshpSFrD3/6aQbCaS8JJ/+LB6WGILy
         cXhrFYshUh0WVB+vvZ7KMYjbF4jwiskqHZytnM7nNhiUW+cf14wo29i7+EKyJu6WMJwj
         zQkUinSLVZxEB357Gjw1w/o0U5Uw8M2PQ+cSM8P6JL0NPfoF366jh4/u4NHy8NnGBz2P
         44jBZRgFzU2XlywjsZAFJnslaWMJl1CBDlyhgSKUuPaJf0qphyNZ8j4XGB3aJbYVyXTT
         HsRMk2heKPXzZU5rfB6BABf2eExmbg04t9wwpD4j6SqBQFkUScdd4oxyAWQaJly/ZnwU
         JoaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqbHMN1MyPmbDCJKgfd81a1txemImlshYXd2QP9cgp52LHddJvlXdCRj1iCtIwiD+zP5/6Swl56zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+EgyKPDvr8wrqjXijukBfarS0ZXduwtUaIRi/nazKrLyTBjAd
	JiFPp7t64L1f/icUUkCTAWy/CLv1EKQaixOXAFdlacRqIhxqtNVCXTh5jtPxA6uh4cg2gBXFOoQ
	uU0qHfKo8p7r3m6+Kpn36KOpQZ/Rx6KVuJntpDz90JulI4Uw8O+b1SxSTL27FuWg=
X-Gm-Gg: AY/fxX6xOudCcCyGiHDF3w37gJlj7Msf412LtOoWPsmeiDU8EK08fiAlShpLlivdlsI
	v1avlVy7S/SHWr2akAKhDFsQA6Y+wBYPw4KVPrH7cvyvqNYds0A1YLP/jXMcQ2/n06NXjNv00I+
	gcIQ8FlBfWf4L/7losmeripZrqgTHU0uHlH15w8I7G2QAw23SJs3jZTDaY7EbFk30BxQPQLR363
	irnxiIl3s916nKXwwLCTEu6uJlyDmJvj8gEWoJEKWoA9IRAa/QaMpkgCdXfVjdnU24gNFM1+jiO
	GXcrLU64J0ty7F/Z6tHorxH+NG248Dl0StTi3R9VllfwBKndBBG/TjqjoUPF/UiYSJemLr0F5T5
	MHNL8u6qmoK7BnYbJ9MhDxN8eso+59JsGZ0PZs0Fk2230vXe3T4KUMkPgbmQ0kWntfRWUPtvpji
	IE2lzShy0XHW20k/A1SOlLx64=
X-Received: by 2002:a05:6808:528e:b0:450:a9d0:b790 with SMTP id 5614622812f47-45a6beb59efmr5451145b6e.46.1767967421604;
        Fri, 09 Jan 2026 06:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhed6/gC1XQdYPnbtJvfwFpetbHTMNUPdnIOYHCqjQqJOeAFrw62c6frHz86sCY1b039DemA==
X-Received: by 2002:a05:6808:528e:b0:450:a9d0:b790 with SMTP id 5614622812f47-45a6beb59efmr5451093b6e.46.1767967420959;
        Fri, 09 Jan 2026 06:03:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38302bd92fbsm14199561fa.3.2026.01.09.06.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 06:03:39 -0800 (PST)
Date: Fri, 9 Jan 2026 16:03:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] phy: qcom: qmp-pcie: Skip PHY reset if already up
Message-ID: <cvxvq7f2ku6aq5gbbqav42ckqk2raesbxq2bx46mxvapcza5v4@5zuyjdtn5us2>
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-1-7e6782230f4b@oss.qualcomm.com>
 <nmle3y6nb4kjcwstzqxkqzaokeyjoegg6lxtmji57kxwh5snxa@p76v6dr7rgsg>
 <53f0c45f-7f5c-4abd-af84-cbb82d509872@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f0c45f-7f5c-4abd-af84-cbb82d509872@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEwNCBTYWx0ZWRfX7bhEPowGaf0Y
 1jT4BzlQVXP1KTPaKHyU++iin1/hOoOVnYGR3grNl1RqUD0+r+XlEYRiQXmIyeZTMwwNQV1lyxL
 h6PKU0UpSsmHjXCu5Q4gmzHkkBJ9cCSCoJp7dwVplEs0If5JUpb7e1edosuGhBznUbRtG57Q8gF
 Vnp0+jsTTp0AzFerN3j0amsEJq2to9KxuykvxJCC43aC8iG+2bsn1mYwTpzS8cruWk/LjPJRBQr
 RcYzu4iacTB74IVmo1OMkENqOWxjghoVAQ3XIEUqvc5ACJcP1XrnU7cgdf0g5FJbgAYF+I0XlS2
 9Mse9G5hWDGX+QChk3KtTpWaSvOF//5UZNSFcJdRjOsXTOP0uOabAg2t8UWFI3vRjYxvH0MuLMf
 g1uKfxWHWymTS8fvREvvFgPP62lmco65BYX2TfWxEYECyanoN9HKcZDSZ3Jbkpj6LWHVb+s/vCb
 NAhTMUP8Ae/x779oR+g==
X-Proofpoint-GUID: HEkR4ZVClNMXRBU7tDhBMUdQBV0TnIOR
X-Proofpoint-ORIG-GUID: HEkR4ZVClNMXRBU7tDhBMUdQBV0TnIOR
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=69610abe cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=lHV2lZlUvwFcl_mAknkA:9 a=CjuIK1q_8ugA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090104

On Fri, Jan 09, 2026 at 02:10:49PM +0100, Neil Armstrong wrote:
> On 1/9/26 14:08, Dmitry Baryshkov wrote:
> > On Fri, Jan 09, 2026 at 12:51:06PM +0530, Krishna Chaitanya Chundru wrote:
> > > If the bootloader has already powered up the PCIe PHY, doing a full
> > > reset and waiting for it to come up again slows down boot time.
> > 
> > How big is the delay caused by it?
> > 
> > > 
> > > Add a check for PHY status and skip the reset steps when the PHY is
> > > already active. In this case, only enable the required resources during
> > > power-on. This works alongside the existing logic that skips the init
> > > sequence.
> > 
> > Can we end up in a state where the bootloader has mis-setup the link? Or
> > the link going bad because of any glitch during the bootup?
> 
> Good question, can we add a module parameter to force a full reset of the PHY in case
> the bootloader is buggy ?

I'd suggest a simpler thing: if the reset was skipped, reset the PHY in
case of an error and retry. That's also one of the reasons why I asked
for skip_reset not to be the persistent value.

> 
> > 
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 28 ++++++++++++++++++----------
> > >   1 file changed, 18 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > > index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..c93e613cf80b2612f0f225fa2125f78dbec1a33f 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > > @@ -3153,6 +3153,7 @@ struct qmp_pcie {
> > >   	const struct qmp_phy_cfg *cfg;
> > >   	bool tcsr_4ln_config;
> > >   	bool skip_init;
> > > +	bool skip_reset;
> > >   	void __iomem *serdes;
> > >   	void __iomem *pcs;
> > > @@ -4537,6 +4538,9 @@ static int qmp_pcie_init(struct phy *phy)
> > >   		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START) &&
> > >   		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn_ctrl);
> > > +	qmp->skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
> > 
> > It is definitely not a long-term state, there is no need to store it in
> > qmp_pcie struct.
> > 
> > > +							    cfg->phy_status);
> > > +
> > >   	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
> > >   		dev_err(qmp->dev, "Init sequence not available\n");
> > >   		return -ENODATA;
> > > @@ -4560,13 +4564,15 @@ static int qmp_pcie_init(struct phy *phy)
> > >   		}
> > >   	}
> > > -	ret = reset_control_assert(qmp->nocsr_reset);
> > > -	if (ret) {
> > > -		dev_err(qmp->dev, "no-csr reset assert failed\n");
> > > -		goto err_assert_reset;
> > > -	}
> > > +	if (!qmp->skip_reset) {
> > > +		ret = reset_control_assert(qmp->nocsr_reset);
> > > +		if (ret) {
> > > +			dev_err(qmp->dev, "no-csr reset assert failed\n");
> > > +			goto err_assert_reset;
> > > +		}
> > > -	usleep_range(200, 300);
> > > +		usleep_range(200, 300);
> > > +	}
> > >   	if (!qmp->skip_init) {
> > >   		ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
> > > @@ -4641,10 +4647,12 @@ static int qmp_pcie_power_on(struct phy *phy)
> > >   	if (ret)
> > >   		return ret;
> > > -	ret = reset_control_deassert(qmp->nocsr_reset);
> > > -	if (ret) {
> > > -		dev_err(qmp->dev, "no-csr reset deassert failed\n");
> > > -		goto err_disable_pipe_clk;
> > > +	if (!qmp->skip_reset) {
> > > +		ret = reset_control_deassert(qmp->nocsr_reset);
> > > +		if (ret) {
> > > +			dev_err(qmp->dev, "no-csr reset deassert failed\n");
> > > +			goto err_disable_pipe_clk;
> > > +		}
> > >   	}
> > >   	if (qmp->skip_init)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

