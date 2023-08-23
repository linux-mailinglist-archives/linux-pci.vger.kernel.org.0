Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8070C784E03
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 03:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjHWBGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 21:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjHWBGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 21:06:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572F0CD1;
        Tue, 22 Aug 2023 18:06:10 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MNDtuj000561;
        Wed, 23 Aug 2023 01:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=4aXrqKlZTt7Yh2jQnv5VHpr/3pqlm0C6Kg/qY923u0A=;
 b=Y1HisRqcoo8jovBIotc2C9DxGS4/JFlaA3Sxo8mGhPFDc1rD+CkliV1Uj19OqUUEpGln
 +R28Zsb5zYc0+0wkjaUsxDjLtC5PT+NyRwCmyfFUYBZaxynrB2dXx+2g+VmPOlwyf5sZ
 Lk9Dwda6dMK0IbDybXZF1hAec60X8GaHpthpxDPdO/RiNivyjOVh9qTRkWfH0+J0Z6eR
 fPrOYJuq7smPkNkCaA+0I8NJ/4v9CbNAAdOWpe1J5Y5Y6Zz3w/oB7fVv087eQuosVnlb
 XbSC78jH6p1KuDVJ1elfjIkaiUeIeoY6/X0MxpSRPiKQf2hMUhReUfZ7iH2PCccFhx0P kg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn25vgpj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 01:06:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37N160xs022351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 01:06:00 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 18:05:55 -0700
Date:   Wed, 23 Aug 2023 06:35:51 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "Nishanth Menon" <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPERATING PERFORMANCE POINTS (OPP)" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] OPP: Add api to retrieve opps which is at most
 the provided level
Message-ID: <20c40635-0ad9-4de3-b18b-ccbcc2fd3779@quicinc.com>
References: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
 <1692717141-32743-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1692717141-32743-4-git-send-email-quic_krichai@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eD3X0klzD_2hZd2UoDA4ibu_zSeJ_U8R
X-Proofpoint-GUID: eD3X0klzD_2hZd2UoDA4ibu_zSeJ_U8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_22,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 22, 2023 at 08:42:20PM +0530, Krishna chaitanya chundru wrote:
> Add dev_pm_opp_find_level_floor() for searching a lesser match or
> operating on OPP in the order of decreasing level.
> 

"OPP: Add api to retrieve opps which is at most the provided level". Pls
change this to "opp: Add dev_pm_opp_find_level_floor()". The API name
conveys the message.

In the description, you can give a use case. i.e voting for the max
level during initialization of a driver.


> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/opp/core.c     | 26 ++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  4 ++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 954c948..e668cf2 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -727,6 +727,32 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
>  
> +
> +/**
> + * dev_pm_opp_find_level_floor() - Search for a rounded floor freq
> + * @dev:	device for which we do this operation
> + * @freq:	Start level
> + *

%s/freq/level

Run make W=1 so that kerneldoc is tested.

> + * Search for the matching floor *available* OPP from a starting level
> + * for a device.
> + *
> + * Return: matching *opp and refreshes *level accordingly, else returns
> + * ERR_PTR in case of error and should be handled using IS_ERR. Error return
> + * values can be:

What do you mean by refresh here?

> + * EINVAL:	for bad pointer
> + * ERANGE:	no match found for search
> + * ENODEV:	if device not found in list of registered devices
> + *
> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> + * use.
> + */
> +struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
> +					      unsigned long *level)
> +{
> +	return _find_key_floor(dev, level, 0, true, _read_level, NULL);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_floor);
> +
>  /**
>   * dev_pm_opp_find_bw_ceil() - Search for a rounded ceil bandwidth
>   * @dev:	device for which we do this operation
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index dc1fb58..a3bc386 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -128,6 +128,8 @@ struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
>  					       unsigned int level);
>  struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>  					      unsigned int *level);
> +struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
> +					      unsigned long *level);
>  
>  struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
>  					     unsigned long *freq);
> @@ -285,6 +287,8 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
>  
>  static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
>  					unsigned int *bw, int index)
> +static inline struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
> +					unsigned long *level)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
> 
Please run ./scripts/checkpatch.pl --strict <your patch> and fix the
indentation warnings from this patch.

Thanks,
Pavan
