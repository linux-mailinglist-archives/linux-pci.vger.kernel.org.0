Return-Path: <linux-pci+bounces-37379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B39EBB2131
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 01:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40B719C5A8D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1233299948;
	Wed,  1 Oct 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzATrGwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521CF28CF77
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759361830; cv=none; b=QJr/Gqtgibs8oRUXzlTYs7Yy/MEo6MyQj9b+438YkUUtSE58nGDr1Z/To4eTQQKRqUehgm74c1iwjWK2+Dn5gLX9NPGM20gjhH63eAXaUv/6QJwrDCdzeexZbsU+5leJDj+k+RbstpcmL4qOONQiOIpPMbo1TIi+9VpZXcufeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759361830; c=relaxed/simple;
	bh=/5iicqHQjoGwUlM+9rOZ5LTZwwl6tmDWHqqXpweuOEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxBY02OYkVkQKm6kE7/5Zr4Q1xGSVZSZHvzyxVXicK8W3ua+ImcRR5VS4RgEr+S6ZqkN7UaoVY7hQCey673F+veyGTvJvovsa9CLjfLsZTs/ZF/A1AkuBX33Z1Htv7pXtdDWhoYM4Ocdwkpxp67Dkxdu9YdT//86SSkg3fMmDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzATrGwF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcMR6010597
	for <linux-pci@vger.kernel.org>; Wed, 1 Oct 2025 23:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kUhpV5L9OVSY0jP0UCvDdukq
	clE+5qyGR802XH0NEj0=; b=MzATrGwFoZwGj85rvlhUJAGeRvpuIBuJ1gw4quo6
	eeAENKlTkHIoSvkMnAmdtv6gU8EvGkUNeA+Q1JmwuLfQEKa/63Dy+wlXj6AtI2IE
	FcrsyyPRTBzt4k0zfTDHGYe3Gey2jUQXlOA5QgiO8sh9GIGVxpCAYH+oG76jaK+w
	5+NRyvV3cDcnb+/YiLnZFEFp9mwyelq6FRaJe+O734QdjPXF1Pm06P7dAVxLowFz
	KI0Swx/Aygd7llojuoqLvCVZLyf0csBAnWk/sejEPJaPlHCZ86iMyEerIr+0qi9y
	cffKt8abX5ZD7ddiWeF8L+SwRoyhu7nmHQNVaomHWx9oMw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hnvs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2025 23:37:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737e673so499464a12.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2025 16:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759361825; x=1759966625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUhpV5L9OVSY0jP0UCvDdukqclE+5qyGR802XH0NEj0=;
        b=LWxtm/EtRAhdMRyl0IImKfPufT8wv6PXgROFH5Rm2XfgG45tfFV2dOd1ijEydhrvjE
         TE9uNLmmhFyZRRA9dKTMj7px5gkPSOkUaDbuiU+inYwka/l45fXEnmdiAB3E7PVfEJCL
         bUicyyZx1GiSWPv54ktHdgggMO4J9OPHRoJYg56cwsLsyaAkozs4ysXOXFeFdtsxhPjj
         zoKQTPnmKM6U4fgCauUe7ZGXJGD/d+S43sJm59qc4fS82JSA/xk2Kd48hfHN4lGwfWKv
         wio/R3gGu2Xy8e5h20zvzT1f62rDvR5dJbYOU6V4ZcQwAdUoQu1DZJK7Xm9pHl5ExmyT
         0xbw==
X-Forwarded-Encrypted: i=1; AJvYcCWMkrVzd6mZ/0hROsJPCixagw6rfy9PlfyjXoLM9W9KI/cMFjVrPDJc4UTftEByZfy9RqCrpXY6ecc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5r0gqhncFuF0fp03nyVekU6o0puHA2j1zo+UOWLeZ7BR+PU76
	uUzCTdzOQH+1+XY/yMn0O1OK13S0fiRTnqfnXqNWBinZgfuuL5VWIrmyxL6GSAB9sPNcr2uytD1
	2V1V5tPahdeaiSKlpEUastvMCx8UrxoBgmwKWH8Ww2hc4S8e5zv6VE+Bcza+F3J8=
X-Gm-Gg: ASbGnctcruRdY8M9rBKxMNYhBb4yGiGhkckIjLcRWJ4mU9SlYFTh3qR3ZRGWlqLtqiZ
	t53GvWYLObBSZ1I5bmv0R+o+pI6th2If+fAOfkJCKDrd/SE7Zf/VBAhNTikNBoUjamCW/UQm0rt
	zYg5xF2/saWZsPKNsEp90xSyFB8IALd5fAf89hNeJ3UkCS+wxjxfwzCL/e9j3okN4fRTkavrP/z
	gK1O0LMSDBHPYK4OlBp/sJ/NIKlrUrkmuxd05jl86H83LQT0Af/O3SCAD+kuLf0R6qI61heyE8y
	E1FH6M4sKaabUSDZSa0RLJ36GrKP4WJzKNgXiDdzZVNAtL5knJDV1nqUeEup8Oca1zYE3rg5EJH
	bu2zoYLHuDb0aSN50yAUUd4jverNG
X-Received: by 2002:a17:902:82c6:b0:269:a8a8:4029 with SMTP id d9443c01a7336-28e7f16792bmr52107325ad.5.1759361824787;
        Wed, 01 Oct 2025 16:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhsy+qF/B38JhyqIfiaawE+CjEz1XsZfy+/GEYo2B04BMyD9Lk33BJRu/DQ31TIUc3DOq43A==
X-Received: by 2002:a17:902:82c6:b0:269:a8a8:4029 with SMTP id d9443c01a7336-28e7f16792bmr52107025ad.5.1759361824293;
        Wed, 01 Oct 2025 16:37:04 -0700 (PDT)
Received: from hu-bjorande-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1280a1sm7543645ad.51.2025.10.01.16.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 16:37:03 -0700 (PDT)
Date: Wed, 1 Oct 2025 16:37:01 -0700
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
Message-ID: <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
 <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX1uEO0dO80/Bd
 y6zQhHeSFLONmXJnfq/LIwZFRdFxpkUgIENnPOicc/j4YdwKpz+XP493Q/wsVUiXPUFpmSrdb80
 h1odROOqi/dcjC+6Hnz+jH+v8VridvWW718oCz8bkSPU/n8+YrPx3YRLY3pnEt25HaA2uxQBcAA
 StLatxzfmstNjiqrA/ezZV/9hLPN/WktvKB/hG3hshJ+GEB//rCU8RGoGz/YmE6A19goS3mYOtV
 2byEzOplWY+BwPhf7MkNqfONwWxnozOxorUkffHuw4/Akka89+N1v/GfqD2ghKcXk1SS21bIDjF
 jp28cq/kvptbMPjEhO7iqneszo+37vnneOhAkyCKNW892FzbIczmNoykVP5QpC2LmQ7XUsxgj/G
 1GKav6RDy5pe4YsnYNjaZx8wCuxfqA==
X-Proofpoint-GUID: g9GWM8qEyg7zF23TeVgArF3BK62ewK0o
X-Proofpoint-ORIG-GUID: g9GWM8qEyg7zF23TeVgArF3BK62ewK0o
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68ddbb22 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=yW6qr2ef8xeCN_ra_UgA:9
 a=xF2dmcnjyTH3buFl:21 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
> and x2 lane.
> 

I tried to boot the upstream kernel (next-20250925 defconfig) on my
Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
is crashing during boot as PCIe is being probed.

Is this a known problem? Is there any workaround/changes in flight that
I'm missing?

Regards,
Bjorn

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 180 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 179 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index 4643705021c6ca095a16d8d7cc3adac920b21e82..b47668a64bcead3e48f58eeb2e41c04660493cb7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -631,7 +631,7 @@ gcc: clock-controller@100000 {
>  			clocks = <&bi_tcxo_div2>,
>  				 <0>,
>  				 <&sleep_clk>,
> -				 <0>,
> +				 <&pcie0_phy>,
>  				 <0>,
>  				 <0>,
>  				 <0>,
> @@ -3304,6 +3304,184 @@ gic_its: msi-controller@16040000 {
>  			};
>  		};
>  
> +		pcie0: pcie@1c00000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-sm8750", "qcom,pcie-sm8550";
> +			reg = <0x0 0x01c00000 0x0 0x3000>,
> +			      <0x0 0x40000000 0x0 0xf1d>,
> +			      <0x0 0x40000f20 0x0 0xa8>,
> +			      <0x0 0x40001000 0x0 0x1000>,
> +			      <0x0 0x40100000 0x0 0x100000>,
> +			      <0x0 0x01C03000 0x0 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x23d00000>,
> +				 <0x03000000 0x4 0x00000000 0x4 0x00000000 0x3 0x00000000>;
> +			bus-range = <0x00 0xff>;
> +
> +			dma-coherent;
> +
> +			linux,pci-domain = <0>;
> +
> +			msi-map = <0x0 &gic_its 0x1400 0x1>,
> +				  <0x100 &gic_its 0x1401 0x1>;
> +			msi-map-mask = <0xff00>;
> +
> +			num-lanes = <2>;
> +
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7",
> +					  "global";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
> +				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "noc_aggr",
> +				      "cnoc_sf_axi";
> +
> +			interconnects = <&pcie_noc MASTER_PCIE_0 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +					 &cnoc_main SLAVE_PCIE_0 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "pcie-mem",
> +					     "cpu-pcie";
> +
> +			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_0_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc GCC_PCIE_0_GDSC>;
> +
> +			operating-points-v2 = <&pcie0_opp_table>;
> +
> +			status = "disabled";
> +
> +			pcie0_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/* GEN 1 x1 */
> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +				};
> +
> +				/* GEN 1 x2 and GEN 2 x1 */
> +				opp-5000000 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +				};
> +
> +				/* GEN 2 x2 */
> +				opp-10000000 {
> +					opp-hz = /bits/ 64 <10000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <1000000 1>;
> +				};
> +
> +				/* GEN 3 x1 */
> +				opp-8000000 {
> +					opp-hz = /bits/ 64 <8000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <984500 1>;
> +				};
> +
> +				/* GEN 3 x2 */
> +				opp-16000000 {
> +					opp-hz = /bits/ 64 <16000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <1969000 1>;
> +				};
> +
> +			};
> +
> +			pcieport0: pcie@0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range = <0x01 0xff>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +				phys = <&pcie0_phy>;
> +			};
> +		};
> +
> +		pcie0_phy: phy@1c06000 {
> +			compatible = "qcom,sm8750-qmp-gen3x2-pcie-phy";
> +			reg = <0 0x01c06000 0 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&tcsrcc TCSR_PCIE_0_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_0_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "ref",
> +				      "rchng",
> +				      "pipe";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			power-domains = <&gcc GCC_PCIE_0_PHY_GDSC>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie0_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		ufs_mem_phy: phy@1d80000 {
>  			compatible = "qcom,sm8750-qmp-ufs-phy";
>  			reg = <0x0 0x01d80000 0x0 0x2000>;
> 
> -- 
> 2.34.1
> 

