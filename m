Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3631F798154
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 06:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbjIHEoj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 00:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbjIHEoi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 00:44:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D4B1FC6;
        Thu,  7 Sep 2023 21:44:28 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3883QYFo012349;
        Fri, 8 Sep 2023 04:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tpfvGfVGoMgya/hP2jj/Kha4fl8r3QnMVMTXIN+MxiQ=;
 b=l4T7uOfmv7IuXxC5nipTF/OpKPT1Gn5l9TQPWQjl5EQNAEI4xTbA4lGiF9wF4LOW1qq+
 jV/R1wJtNWHebTgGrXbz5rNdPJh4Gv0SASdkAOI5m7Z7GXdBmV8/+H2wJwQpbPTNitd5
 Vn+QH1iQIhbzJhzADocOHw6f3ZAloyrGTgUEjZkJY2pH1r1uy4QALqvrw7hJg5DAByPW
 YYHnnq5IpJyxbS/mEWF0BpagOReaJFgLT0l0M6J4zu6s2VCTmHaWR/NFnqAOlkVW4BGw
 vd41WwWrBfaFoqxOtzcANGfytDVBUD1lvbM51ieH1clh45W9XHCsFFOzruTYqD2e3sr+ uA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy50dawgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 04:44:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3884iFJV031528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 04:44:15 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 21:44:09 -0700
Message-ID: <b7eade65-8fa2-05e0-4ab1-fdfca7ad1a40@quicinc.com>
Date:   Fri, 8 Sep 2023 10:14:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 1/4] PCI: endpoint: Add D-state change notifier support
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        kernel test robot <lkp@intel.com>
CC:     <manivannan.sadhasivam@linaro.org>,
        <oe-kbuild-all@lists.linux.dev>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <1690948281-2143-2-git-send-email-quic_krichai@quicinc.com>
 <202308021312.obgu7FWM-lkp@intel.com> <20230823061904.GC3737@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230823061904.GC3737@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VAGQX_O0J--bQfxDZwz_naMK78xlsc48
X-Proofpoint-GUID: VAGQX_O0J--bQfxDZwz_naMK78xlsc48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_01,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080042
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/23/2023 11:49 AM, Manivannan Sadhasivam wrote:
> On Wed, Aug 02, 2023 at 01:14:44PM +0800, kernel test robot wrote:
>> Hi Krishna,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on pci/next]
>> [also build test WARNING on pci/for-linus linus/master v6.5-rc4 next-20230801]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-endpoint-Add-D-state-change-notifier-support/20230802-115309
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
>> patch link:    https://lore.kernel.org/r/1690948281-2143-2-git-send-email-quic_krichai%40quicinc.com
>> patch subject: [PATCH v5 1/4] PCI: endpoint: Add D-state change notifier support
>> config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230802/202308021312.obgu7FWM-lkp@intel.com/config)
>> compiler: loongarch64-linux-gcc (GCC) 12.3.0
>> reproduce: (https://download.01.org/0day-ci/archive/20230802/202308021312.obgu7FWM-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202308021312.obgu7FWM-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/pci/endpoint/pci-epc-core.c:795:6: warning: no previous prototype for 'pci_epc_dstate_notity' [-Wmissing-prototypes]
>>       795 | void pci_epc_dstate_notity(struct pci_epc *epc, pci_power_t state)
> This tells that you haven't build tested the series before sending. Please
> always do both build and functionality testing before sending each iteration.
>
> - Mani

sorry for late reply, till now I was using a different branch which has 
some out of tree patches for testing and rebasing the patch on 
linux-next to send them because of that few things are getting missed.

Now I took time to completely move to the linux next so that testing and 
sending patches will be on same code base.

I will correct this in next patch series.

- KC

>>           |      ^~~~~~~~~~~~~~~~~~~~~
>>
>>
>> vim +/pci_epc_dstate_notity +795 drivers/pci/endpoint/pci-epc-core.c
>>
>>     785	
>>     786	/**
>>     787	 * pci_epc_dstate_notity() - Notify the EPF driver that EPC device D-state
>>     788	 *			has changed
>>     789	 * @epc: the EPC device which has change in D-state
>>     790	 * @state: the changed D-state
>>     791	 *
>>     792	 * Invoke to Notify the EPF device that the EPC device has D-state has
>>     793	 * changed.
>>     794	 */
>>   > 795	void pci_epc_dstate_notity(struct pci_epc *epc, pci_power_t state)
>>     796	{
>>     797		struct pci_epf *epf;
>>     798	
>>     799		if (!epc || IS_ERR(epc))
>>     800			return;
>>     801	
>>     802		mutex_lock(&epc->list_lock);
>>     803		list_for_each_entry(epf, &epc->pci_epf, list) {
>>     804			mutex_lock(&epf->lock);
>>     805			if (epf->event_ops && epf->event_ops->dstate_notify)
>>     806				epf->event_ops->dstate_notify(epf, state);
>>     807			mutex_unlock(&epf->lock);
>>     808		}
>>     809		mutex_unlock(&epc->list_lock);
>>     810	}
>>     811	EXPORT_SYMBOL_GPL(pci_epc_dstate_notity);
>>     812	
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
