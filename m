Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D16B2CC3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 19:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCISSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 13:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCISSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 13:18:39 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF9B6420C;
        Thu,  9 Mar 2023 10:18:36 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329IA6Dw029697;
        Thu, 9 Mar 2023 18:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KK+OAocPYk3r1h9tMZ9MdvYVbSyFkyqOtafvkb9zUak=;
 b=XbjyoCsNgQOynfeC8bC07EPqNt27fNURfLMq/Rdpbdl7baBFZSxKUUCadwBb56Wjs8Dw
 NZeRvnYmikI5v5oEpaHc0WFNyqfa0cPbHv68f34+gwB4bFZfguQjtGwp8obwvPzc6q9M
 sn5vsthms4/68YuHwAYVoAbKXnnGnQ40RIxz3TkZcbTgKgSHDCXt8dIo8Z5G7auurrEb
 kaf8rYwuJ9P/VpL7dZhTSpN3uMwoIXwB/EYK0WH9gIV4IxjXy7QiHkPKEJS5YM3ofu+P
 Hpt2hCD7cJZ51k3ZHHr0GEZ4JjqAheKqAFXOkkgfd6iCmxfK7z2zaJpxOpSKbZ3VDA5k KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6qyqvfgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:18:35 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 329I0gGv012054;
        Thu, 9 Mar 2023 18:18:35 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6qyqvfg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:18:35 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329HkBQ3023629;
        Thu, 9 Mar 2023 18:18:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3p6fnwna9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:18:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329IIXCE33227208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 18:18:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F142C5805D;
        Thu,  9 Mar 2023 18:18:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 141AE5805F;
        Thu,  9 Mar 2023 18:18:32 +0000 (GMT)
Received: from [9.160.169.251] (unknown [9.160.169.251])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 18:18:31 +0000 (GMT)
Message-ID: <01c18e2b-8ec0-46c6-ba95-997b9d9d4ed6@linux.ibm.com>
Date:   Thu, 9 Mar 2023 13:18:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/4] PCI: s390: Fix use-after-free of PCI resources
 with per-function hotplug
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20230306151014.60913-1-schnelle@linux.ibm.com>
 <20230306151014.60913-2-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230306151014.60913-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2JzMxtCeObLVpOvrbLmir_M9TRImWc6d
X-Proofpoint-ORIG-GUID: qvPanSurlKKp9tK_NvLoDAZxIRBevMAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_09,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 phishscore=0 suspectscore=0 mlxlogscore=797
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/6/23 10:10 AM, Niklas Schnelle wrote:
> On s390 PCI functions may be hotplugged individually even when they
> belong to a multi-function device. In particular on an SR-IOV device VFs
> may be removed and later re-added.
> 
> In commit a50297cf8235 ("s390/pci: separate zbus creation from
> scanning") it was missed however that struct pci_bus and struct
> zpci_bus's resource list retained a reference to the PCI functions MMIO
> resources even though those resources are released and freed on
> hot-unplug. These stale resources may subsequently be claimed when the
> PCI function re-appears resulting in use-after-free.
> 
> One idea of fixing this use-after-free in s390 specific code that was
> investigated was to simply keep resources around from the moment a PCI
> function first appeared until the whole virtual PCI bus created for
> a multi-function device disappears. The problem with this however is
> that due to the requirement of artificial MMIO addreesses (address
> cookies) extra logic is then needed to keep the address cookies
> compatible on re-plug. At the same time the MMIO resources semantically
> belong to the PCI function so tying their lifecycle to the function
> seems more logical.
> 
> Instead a simpler approach is to remove the resources of an individually
> hot-unplugged PCI function from the PCI bus's resource list while
> keeping the resources of other PCI functions on the PCI bus untouched.
> 
> This is done by introducing pci_bus_remove_resource() to remove an
> individual resource. Similarly the resource also needs to be removed
> from the struct zpci_bus's resource list. It turns out however, that
> there is really no need to add the MMIO resources to the struct
> zpci_bus's resource list at all and instead we can simply use the
> zpci_bar_struct's resource pointer directly.
> 
> Fixes: a50297cf8235 ("s390/pci: separate zbus creation from scanning")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



