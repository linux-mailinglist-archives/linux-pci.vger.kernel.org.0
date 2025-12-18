Return-Path: <linux-pci+bounces-43269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FEDCCB3B6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47BF830161D8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC2B2F49F6;
	Thu, 18 Dec 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iz5OQ4l3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SOFiNYXG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB52EB84E
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051080; cv=none; b=HbFpfdWURtFWMBhFJugO/0JJIX0Ls2U/Jx1LwaBHR5RYwBRJkJWiznyAPDLsuri5J4it+IlRnpKmYtsJb/vDp4z22O/fWG8kzOuOztytbreKYxnhznm/W/RT6IDKbFspFxhihog/RYp8OnNTN/Be/WDZDJhhwtrAGNsSMkjMS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051080; c=relaxed/simple;
	bh=kSO39PU57qcgQaoFJiWMrPpTa2eBDwJVmdJ1iwIXf+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs1ujcmJFFAE/dNFO/5E5Kaz1MH6jQ0S7nqillmFXuYcTFZkg3hfYvWFG2PN61Wat1m4ZqOKmzmqFjba68k7yNW/YPbSYKvDZUjKpLqBcJkTbxhja9Nu1r8xcHMfe5wijRByzN4LXxkppfIa9FklzW/uc8hRJby4edDHfvzWgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iz5OQ4l3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SOFiNYXG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI8r5Gs3446920
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KfGx7wI1BOPUnfcLuWP4IQEeawcCkgbgGC8no1O26v8=; b=Iz5OQ4l3Q7sUmdzs
	tJrclJCf424lFJzOQTtxkSbBx8SYavI8G5BNHvQdazjR41CjZeixRbTfO0gJkU0e
	n+osMQ7h1kaP7qPGZlzw2NJC92kuP5AnyCStsRMh9XlvZpkDSlGkW+OIo+/SWwK0
	xJa1FcsJbgfjUdScP+XSvuTutZlrX7b7imD93GQQOAWVmOGMPVLfHZt+gaGOAB7v
	4uVohZWwKu3xVhT7g3YcjNGwzn2V/k7i+I858gGsj5ZDmUUWN8Zv6gjwDD192BB9
	yUXgoHZGY6UQIj4C4o3NMi7/aW+A5NpglcE2rj63BGNPmeUoXDfqCMtNBee4Diam
	h5rF3g==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4egb86uq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 09:44:38 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-656ceb0c967so246017eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 01:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766051077; x=1766655877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfGx7wI1BOPUnfcLuWP4IQEeawcCkgbgGC8no1O26v8=;
        b=SOFiNYXGY9c88TBcUOQH9nd7bSzcGtdRDqfZdUqsGJuQ8s3CzbkzvKUq3DODl7Iuoi
         j8ZCPJLA/Shgatp22HHP244+bEa8q6+fj6jiVHCtavQmwfiKUqTm7LoCehRfoevk69vx
         lj/DC6wX0RXX8wIKJBqlUNM2xe5WPuJNzw84CZkMUY3HTHV0wgytRVfCjkXFz60Xdc8j
         4ShjoIlqlpoDjNCtdaQmOblCqolG1ZPVCczU6nD8kKai+JERRcaE3SgcUcT7IdYit/ij
         xG3bWkGF2RTpc7v6uUbbxbclvWHTIViEhLWmsQqSaJMzm+yTJSxzEbt0cIrRUxvMSkUU
         TbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766051077; x=1766655877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfGx7wI1BOPUnfcLuWP4IQEeawcCkgbgGC8no1O26v8=;
        b=kBMgKs3bGQRFS2t931+NFSZquAuzz+n94jRUyU5f+mv8xlfFhp3wHJZDgzAmto4rZD
         VQ4JBRmPCqANwotoUoe3r7vYeLygzNF4LO/ykKTQZfrMSH+qxBXrhSTZTlJWuY8102Dl
         tCH5Xr1Q+mvE2i2TjOrMTbeBLq6bhdrC+ugxMw8JzRBxzZ05FtiVPVfIMSH+o9OgILB0
         Rc9ERCPDYQUxDmVFEZw+zCXkmrr8gyXLsTzZoCme6mVMq0aZuPSFzamd2sujLr3XM/xz
         eXvHeAEjmzEtzC7InmEaDSnNeuIjLm/irC9IS6/blunkE03D20GpSNa86xO/JQM+sZze
         KfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsulxcYbUDXURmYYESuCJCCvOIreVWFhjVewwTn4NRX9Rh4Mpwl+kOwpg7TW+Di5i71AuUgf3KrPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31b8eWSmXMdVjpWPAJ8g63m+wGdU5BfJBoYiE2Jy9X/xzAvK0
	aXKqEqJbGsjbQ+vBIJc66d3FYn+5vS7NeMeLOioTwORqjf1QPtkJKc9BPbG46hREDRh/nFq0Q9g
	zRsx/4tknKU/Xjscx6gwBFJhxQP9k3aeujcon1OBAmQNHqB36tuMobD0lwWSym9dN0zY/Yof30o
	z2dHYTnjbE1rZm6qigdOBsrSPin70g9va5oM9YTA==
X-Gm-Gg: AY/fxX760qv3RI2RduRN/Sdt6hpfmUtZRoP2AAT7e2AvKVhnfqmKqYaPULGEcpS/tpZ
	PEnEyZ98cu8eIUpPUjSpreCKRAMd/kwfVCJTb56Ll2WXCqpZKmTj2PX1sPIidMGIhbYajBEKtTH
	KvUVzGAo7vu9G42Edgk7OrKuGzVHEgPDBoCHqJochbCuP0H5Mn+Xfb6vHZzrQ460/+0Sc=
X-Received: by 2002:a05:6820:4b8f:b0:659:9a49:8e0d with SMTP id 006d021491bc7-65b452735b6mr8721915eaf.79.1766051077075;
        Thu, 18 Dec 2025 01:44:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERtNGbEKoDPQLE8IxnUqLmybaozyc//6YjJWrT5Q2BhKp84MiZQp4oxb5W8Rbaq50Jo7poy9dUGD8cZnIo7lQ=
X-Received: by 2002:a05:6820:4b8f:b0:659:9a49:8e0d with SMTP id
 006d021491bc7-65b452735b6mr8721888eaf.79.1766051076698; Thu, 18 Dec 2025
 01:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217-firmware_managed_ep-v3-0-ff871ba688fb@oss.qualcomm.com>
 <20251217-firmware_managed_ep-v3-1-ff871ba688fb@oss.qualcomm.com> <176597111816.570337.1780092644304118894.robh@kernel.org>
In-Reply-To: <176597111816.570337.1780092644304118894.robh@kernel.org>
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 15:14:25 +0530
X-Gm-Features: AQt7F2ojmCPtN109SgIRp92s-vWGgNIdWrPbcwrp_WpHtLn1UwYz0anVJVFw0vs
Message-ID: <CAMyL0qOEzqKTJuZRuopGioZRk3DzYoeyRZjNB6JLa8yQEBedLQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: qcom,pcie-ep-sa8255p: Document
 firmware managed PCIe endpoint
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        quic_shazhuss@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        quic_vbadigan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA3OSBTYWx0ZWRfX61iEFyYZuEPq
 +108Lxc25riLhAAN4ojHNEsnRMnJXlcJBHELCpWlsI6F+2v7vBAEhwERlxdHjGZJ8Nv05qHf5ul
 nqztxJnCjxstk1vcWccWNOnc4zrlY+uAJGmx9nrJxrc3cOblzpMtlr9J0cMXy/5CRnf8t6/K0nS
 4bG1tY20rPYLZJKPquIF9Uz3ugakkq0ezzolu2ZP7D2WUgMAGL6dfUuyYHIUa/nB5viGLdFnCuP
 27w/5UeOKTRoktVozkYzCLikw5U/ELw3/3IzNgh6G6MWe3VumDG7tjFGbACPSGY0kuYSOfOaexZ
 VX7589wjDr8AaQR06vhmzC6C4NVp8/oXJaxiDXvjE6xm6RKOagOtVXrFL9ni/VcWMmHeVmcmN52
 wrCq6PNTl794NaZrYGEJ5uRjKD2yPw==
X-Authority-Analysis: v=2.4 cv=M9tA6iws c=1 sm=1 tr=0 ts=6943cd06 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=WDKAYucIsvLUd7uitsUA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: UU9r-VZKuazhqVJb01aZDStIicId6MWz
X-Proofpoint-ORIG-GUID: UU9r-VZKuazhqVJb01aZDStIicId6MWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512180079

On Wed, Dec 17, 2025 at 5:02=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Wed, 17 Dec 2025 15:42:45 +0530, Mrinmay Sarkar wrote:
> > Document the required configuration to enable the PCIe Endpoint control=
ler
> > on SA8255p which is managed by firmware using power-domain based handli=
ng.
> >
> > Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> > ---
> >  .../bindings/pci/qcom,pcie-ep-sa8255p.yaml         | 110 +++++++++++++=
++++++++
> >  1 file changed, 110 insertions(+)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/qcom,pcie-ep-sa8255p.example.dtb: pcie-ep@1c10000 (qcom,pcie-ep-sa8255p)=
: compatible: 'oneOf' conditional failed, one must be fixed:
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,(apq|ipq|mdm|msm|qcm=
|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$'
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,sar[0-9]+[a-z]?-.*$'
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,(sa|sc)8[0-9]+[a-z][=
a-z]?-.*$'
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,(glymur|milos)-.*$'
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,[ak]pss-wdt-(apq|ipq=
|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,gcc-(apq|ipq|mdm|msm=
|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,mmcc-(apq|ipq|mdm|ms=
m|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,pcie-(apq|ipq|mdm|ms=
m|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+.*$'
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,rpm-(apq|ipq|mdm|msm=
|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm)[0-9]+.*$'
>         'qcom,pcie-ep-sa8255p' does not match '^qcom,scm-(apq|ipq|mdm|msm=
|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+.*$'
>         'qcom,pcie-ep-sa8255p' is not one of ['qcom,dsi-ctrl-6g-qcm2290',=
 'qcom,gpucc-sdm630', 'qcom,gpucc-sdm660', 'qcom,lcc-apq8064', 'qcom,lcc-ip=
q8064', 'qcom,lcc-mdm9615', 'qcom,lcc-msm8960', 'qcom,lpass-cpu-apq8016', '=
qcom,usb-ss-ipq4019-phy', 'qcom,usb-hs-ipq4019-phy', 'qcom,vqmmc-ipq4019-re=
gulator']
>         'qcom,pcie-ep-sa8255p' is not one of ['qcom,ipq806x-gmac', 'qcom,=
ipq806x-nand', 'qcom,ipq806x-sata-phy', 'qcom,ipq806x-usb-phy-ss', 'qcom,ip=
q806x-usb-phy-hs']
>         from schema $id: http://devicetree.org/schemas/arm/qcom-soc.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20251217-firmwa=
re_managed_ep-v3-1-ff871ba688fb@oss.qualcomm.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.


Hi Krzysztof,

As per our discussion in V1, you mentioned dt binding filename must
match the compatible
and I should rewrite compatible to match filename.

V1 discussion: https://lore.kernel.org/all/CAMyL0qO2FPBe7N6Q=3DhW-ymeiGDhAB=
sU+VCj25jzcoQRhBoWbDA@mail.gmail.com/

So, I have changed compatible to match file name and it seems like
dt_binding_check is reporting errors.
As compatible: 'oneOf' conditional failed.

Can you please confirm if I can use previously used
compatible(qcom,sa8255p-pcie-ep) and update
file name accordingly as even in driver we are using this format for
other compatible.

Thanks,
Mrinmay

