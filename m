Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97F27E09FE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 21:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377895AbjKCUQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 16:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCUQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 16:16:09 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86DCD53;
        Fri,  3 Nov 2023 13:16:06 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3InVPH027262;
        Fri, 3 Nov 2023 20:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=YRqVe93S+RTeQY1jO6ycgOiyquCZBpMTfoyKizhizok=;
 b=fAa1hDq9p88I2q1JQ3Fd0nkzToZn08zcJtunH8/0qKHYI+vYsmU1ANawtXlScA+dOUR3
 BEYEiSXOXHFAeF6V0cWs6eIKdJZjs/M89UxSXoDqtRkHD1hOYhXB9XxWgv4vZ0lMV3IR
 74XxuY1D151ZCyZ8EMRzUbXEabMpGO3MBSd2UvbxrtjHSDUOSzvTyNz7uF59XjZRciX6
 6aqFb5Br/xrt+d8qp/sBRKRgYR2E32CqJzr9TAeor77+EW1POBU70dezJQ08vgJ1ORNY
 BP4lfx5KiIo9uW4wvI06u/kyQCeucL6g+QK0XFUkhRJX6NVZIMBirEC1uiYRmgbjxr6M gQ== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3u519dvh43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 20:15:43 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id C1D8613192;
        Fri,  3 Nov 2023 20:15:42 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 4B73F8005DE;
        Fri,  3 Nov 2023 20:15:40 +0000 (UTC)
Date:   Fri, 3 Nov 2023 15:15:38 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/apic: Drop enum apic_delivery_modes
Message-ID: <ZUVU6tKmhL1VmcbT@swahl-home.5wahls.com>
References: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
 <20231102-x86-apic-v1-2-bf049a2a0ed6@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102-x86-apic-v1-2-bf049a2a0ed6@citrix.com>
X-Proofpoint-ORIG-GUID: MNz1BLDbpvbQ_3nM-UVQvFJUQe232gqd
X-Proofpoint-GUID: MNz1BLDbpvbQ_3nM-UVQvFJUQe232gqd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_19,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxlogscore=520 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030170
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 02, 2023 at 12:26:20PM +0000, Andrew Cooper wrote:
> The type is not used any more.
> 
> Replace the constants with plain defines so they can live outside of an
> __ASSEMBLY__ block, allowing for more cleanup in subsequent changes.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>

Reveiewed-by: Steve Wahl <steve.wahl@hpe.com>

> ---
>  arch/x86/include/asm/apicdef.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
> index 4b125e5b3187..ddcbf00db19d 100644
> --- a/arch/x86/include/asm/apicdef.h
> +++ b/arch/x86/include/asm/apicdef.h
> @@ -20,6 +20,13 @@
>   */
>  #define IO_APIC_SLOT_SIZE		1024
>  
> +#define APIC_DELIVERY_MODE_FIXED	0
> +#define APIC_DELIVERY_MODE_LOWESTPRIO	1
> +#define APIC_DELIVERY_MODE_SMI		2
> +#define APIC_DELIVERY_MODE_NMI		4
> +#define APIC_DELIVERY_MODE_INIT		5
> +#define APIC_DELIVERY_MODE_EXTINT	7
> +
>  #define	APIC_ID		0x20
>  
>  #define	APIC_LVR	0x30
> @@ -430,14 +437,5 @@ struct local_apic {
>   #define BAD_APICID 0xFFFFu
>  #endif
>  
> -enum apic_delivery_modes {
> -	APIC_DELIVERY_MODE_FIXED	= 0,
> -	APIC_DELIVERY_MODE_LOWESTPRIO   = 1,
> -	APIC_DELIVERY_MODE_SMI		= 2,
> -	APIC_DELIVERY_MODE_NMI		= 4,
> -	APIC_DELIVERY_MODE_INIT		= 5,
> -	APIC_DELIVERY_MODE_EXTINT	= 7,
> -};
> -
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_X86_APICDEF_H */
> 
> -- 
> 2.30.2
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
