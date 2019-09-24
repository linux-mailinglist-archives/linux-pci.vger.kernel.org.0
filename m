Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06867BBFF6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 04:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405166AbfIXCXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 22:23:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43646 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfIXCXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Sep 2019 22:23:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O2JJok099740;
        Tue, 24 Sep 2019 02:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=10wtS4xet5XKlLZCQy/C6PImQNv1bpY8LtMkWI4eGA8=;
 b=YIkidpJjC/N3UN+DN7L+93HGNpmn0eYw2A0KmeTlIvsUVaCTakS9WmzSV7fO3S3BRhmL
 FF2jSnaIk3rVoU22OEdnobpuknPtcpba2bZt2LT6izL2VO/lMimVccL6uKd6/JQOnQOQ
 PqYDvI2MO/frEqSFLnmkTp4+9iVhN/o2BGrVNDbSJZoFr8AINncGVTg+leVbPpEZ9s2q
 TcfZa7tU1NKo2cQjFLW9or8P4AXuWjE188XSodwA+S5M7hIVd6SdibaUlo5IB22UL4T0
 fW1Uz5MACaQ6uTB/w93Aid7YebzqJ7KuNX0qZ4HtkJhCkBbHQrHuInTNcnqIym28YIEs xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2v5cgqtp0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 02:22:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O2IEe7182806;
        Tue, 24 Sep 2019 02:22:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2v6yvmdqgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 02:22:50 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8O2Mjrf017801;
        Tue, 24 Sep 2019 02:22:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Sep 2019 19:22:44 -0700
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-scsi@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v3 18/26] scsi: pm80xx: Use PCI_STD_NUM_BARS
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190916204158.6889-1-efremov@linux.com>
        <20190916204158.6889-19-efremov@linux.com>
Date:   Mon, 23 Sep 2019 22:22:42 -0400
In-Reply-To: <20190916204158.6889-19-efremov@linux.com> (Denis Efremov's
        message of "Mon, 16 Sep 2019 23:41:50 +0300")
Message-ID: <yq1wody4eml.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=691
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=790 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240022
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Denis,

> Replace the magic constant (6) with define PCI_STD_NUM_BARS
> representing the number of PCI BARs.

Applied to 5.4/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
