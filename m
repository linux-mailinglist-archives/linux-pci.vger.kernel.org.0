Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A88A41C55B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 15:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbhI2NSg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 09:18:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242801AbhI2NSf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 09:18:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TD0Tpj027476;
        Wed, 29 Sep 2021 09:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8WNH5WIjmi4VXGGXQVQqQGa9LxSWiuKObMKI3R3N3v0=;
 b=eTICHaTe5EWn0Iqkz8yeEUgAvudcmWSKeYOZL3tmsOVg2p/vuJCd3lLc7X4IpTJRsQvN
 N+h9f7ERDYgfvyZzbNdXaYE4xiu6SSMbi+oOoQnXmFqA0MDjRWByMV8QDZklznxhWnP8
 Zfu6Z65PrhA/glaMqoEOzOj4/+LPoWJLpdQ3z2MhMDq2F8jcszdMujO8CYHVNV9Cz7k0
 sstnbptCuAlwXwUd+5bwWpT1qWREPrnHxzZBLT02ytCWu6N5JyvTo1qOy/7Be3XDwwgp
 SBf9sCOqX6+7qHmwe/BbrU7S8zsBAly7zJlvoZTU2jK/RY4l2dgZ/h3Am2Pd3krxwQpW Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bcrn9rbsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 09:15:46 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18TD1Rbo030294;
        Wed, 29 Sep 2021 09:15:45 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bcrn9rbrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 09:15:45 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18TDC3n0019787;
        Wed, 29 Sep 2021 13:15:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3b9ud9xasx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 13:15:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18TDFevi57213414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 13:15:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E44C911C04C;
        Wed, 29 Sep 2021 13:15:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BE3911C05E;
        Wed, 29 Sep 2021 13:15:39 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Sep 2021 13:15:39 +0000 (GMT)
Received: from [9.206.131.40] (unknown [9.206.131.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7E5A9600F5;
        Wed, 29 Sep 2021 23:15:37 +1000 (AEST)
Subject: Re: [PATCH v5 10/11] PCI: Replace pci_dev::driver usage by
 pci_dev::dev.driver
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org
References: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
 <20210929085306.2203850-11-u.kleine-koenig@pengutronix.de>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <75dd6d60-08b9-fa68-352c-3a0c5a04c0ab@linux.ibm.com>
Date:   Wed, 29 Sep 2021 23:15:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929085306.2203850-11-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hXtcU9LxcZFWJ3_AQvYkTcqzdGELwYzx
X-Proofpoint-GUID: JvUu1pq2Dv5jXGImGMo8koe6SjbY5_vk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_05,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=928
 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290081
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/9/21 6:53 pm, Uwe Kleine-König wrote:>   	 
list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> -			if (afu_dev->driver && afu_dev->driver->err_handler &&
> -			    afu_dev->driver->err_handler->resume)
> -				afu_dev->driver->err_handler->resume(afu_dev);
> +			struct pci_driver *afu_drv;
> +			if (afu_dev->dev.driver &&
> +			    (afu_drv = to_pci_driver(afu_dev->dev.driver))->err_handler &&

I'm not a huge fan of assignments in if statements and if you send a v6 
I'd prefer you break it up.

Apart from that everything in the powerpc and cxl sections looks good to me.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
