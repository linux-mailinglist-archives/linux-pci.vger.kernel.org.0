Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8833088B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 08:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCHHCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 02:02:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229843AbhCHHCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 02:02:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1286YILe152059;
        Mon, 8 Mar 2021 02:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bS3eYy+BI51TPab9hgRF1rimg0MIGegF8qUN+OmG5BI=;
 b=e8r1Vxtw4E3FzbzUc64gTx6Yxl32tGfUQeTwykC7PGBe4wtqCT9uL69xNoA84t12/4Zc
 t/BmENQiBzCr5NLOCfxD/Z/Tx4b9dAxWEDYiqAiEubqaJIJ19DoitAw0PbLlz1Zqx26c
 RwX9dDh+2tFhCebQgll8HGhD3yJU9C6gVHChh8oaMq/XqQmVRWQrfmhJpf9VKa2cdoKh
 l/0SX/Csg/FS5taEDG1Htk/x9r9VCxHYdmSjoEHpDvw/KGxH09pp1ww9nBrmbC5+IXIM
 5lid74pujT2sMhDJaIJXELgsuLXTf29HQWTcQ46CXTjGS+dlQwrptxk0hZ89+iu9I2zQ xg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3755xdhu47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 02:02:12 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1286qOUJ014701;
        Mon, 8 Mar 2021 07:02:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3741c89jpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 07:02:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 128728I344892458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Mar 2021 07:02:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CFEAAE053;
        Mon,  8 Mar 2021 07:02:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DEF2AE057;
        Mon,  8 Mar 2021 07:02:07 +0000 (GMT)
Received: from [9.145.174.211] (unknown [9.145.174.211])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Mar 2021 07:02:07 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/pci: expose a PCI device's UID as its index
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Narendra K <narendra_k@dell.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210303095250.1360007-1-schnelle@linux.ibm.com>
 <20210303095250.1360007-2-schnelle@linux.ibm.com>
 <YEU7iFjxNxQK3ldc@rocinante>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <c714ca55-7189-e196-7b8d-f02da555b399@linux.ibm.com>
Date:   Mon, 8 Mar 2021 08:02:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YEU7iFjxNxQK3ldc@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_02:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=864
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1011
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080034
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/7/21 9:46 PM, Krzysztof Wilczyński wrote:
> Hi Niklas,
> 
> [...]
>> +static ssize_t index_show(struct device *dev,
>> +			  struct device_attribute *attr, char *buf)
>> +{
>> +	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
>> +	u32 index = ~0;
>> +
>> +	if (zpci_unique_uid)
>> +		index = zdev->uid;
>> +
>> +	return sprintf(buf, "%u\n", index);
> [...]
> 
> Would it be possible to use the new sysfs_emit() rather than sprintf()
> even though the zpci_attr macro and still use mio_enabled_show() still
> would use sprintf().  What do you think?
> 
> See https://www.kernel.org/doc/html/latest/filesystems/sysfs.html for
> the changes in the internal API.
> 
> Krzysztof
> 

Of course that makes sense and thanks for pointing me to this API!
@Viktor, may I carry your R-b over?

I'll also update the other attributes in a clean up patch.

Thanks,
Niklas
