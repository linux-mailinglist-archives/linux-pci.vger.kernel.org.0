Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D64313277
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 13:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhBHMgp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 07:36:45 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:13680 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231944AbhBHMel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 07:34:41 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118CNJT7010673;
        Mon, 8 Feb 2021 12:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=j0RhL8VBH4OHVt6f0eJH89mDxMAPe1Z2UPjEkMj1OxI=;
 b=YLxsfGnz10PAJHgzkRw/aZNBxilOqOunhq06Z3CrpoSI2zx40pnKpWrAZWDTvWDLJzgL
 I28mWGou2vc0C1/ZyBV+XxGKiwtEJJTVCh7RAnH9yNR9PoOZ7dIDjjXhjwID5tscBpZe
 yYvV92d4yfG5mhy8TGthatLloh4RLVTNp9vWtByarjg0ELZQgVKnssODvUGz1dlP1PCx
 S+6LfHlsFAJzfe16WeZZh/bL3pTP86AqsRQZ/FT3S1RdBAq7dGUEgR7feB5+HyQBbd8Z
 +0Jt0CuPl32o2BAWF43JezYTHoBa8mUk2jujlhG2TZeX/XTOHBnYBLInSHE50XOL/UUL 2A== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 36jymutwqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 12:33:30 +0000
Received: from sarge.linuxathome.me (unknown [16.29.129.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id 0FF7E5B;
        Mon,  8 Feb 2021 12:33:26 +0000 (UTC)
Date:   Mon, 8 Feb 2021 12:33:24 +0000
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Russ Anderson <rja@hpe.com>, Joerg Roedel <jroedel@suse.com>,
        stable@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 1/1] PCI/ERR: don't clobber status after reset_link()
Message-ID: <YCEvlMqx7iC6Czps@sarge.linuxathome.me>
Mail-Followup-To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Russ Anderson <rja@hpe.com>, Joerg Roedel <jroedel@suse.com>,
        stable@kernel.org, Keith Busch <kbusch@kernel.org>
References: <20210108223043.GA1477254@bjorn-Precision-5520>
 <01c316b7-afae-5ce5-0c5a-8878310fa1f6@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <01c316b7-afae-5ce5-0c5a-8878310fa1f6@linux.intel.com>
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_06:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=785
 lowpriorityscore=0 bulkscore=0 clxscore=1011 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080085
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 09:34 Kuppuswamy, Sathyanarayanan wrote:
>
>
>On 1/8/21 2:30 PM, Bjorn Helgaas wrote:
>>Can we push this forward now?  There are several pending patches in
>>this area from Keith and Sathyanarayanan; I haven't gotten to them
>>yet, so not sure whether they help address any of this.
>
>Following two patches should also address the same issue.
>
>My patch:
>
>https://patchwork.kernel.org/project/linux-pci/patch/6f63321637fef86b6cf0beebf98b987062f9e811.1610153755.git.sathyanarayanan.kuppuswamy@linux.intel.com/

This series does *not* fix the problem for me.
>
>Keith's patch:
>
>https://patchwork.kernel.org/project/linux-pci/patch/20210104230300.1277180-4-kbusch@kernel.org/

Keith's series *does* fix the problem for me:

Acked-by: Hedi Berriche <hedi.berriche@hpe.com>
Tested-by: Hedi Berriche <hedi.berriche@hpe.com>

Cheers,
Hedi.
>
>
>
>-- 
>Sathyanarayanan Kuppuswamy
>Linux Kernel Developer

-- 
Be careful of reading health books, you might die of a misprint.
	-- Mark Twain
