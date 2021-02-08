Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73843132CD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 13:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBHM4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 07:56:38 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:23846 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhBHM4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 07:56:38 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118CssgR029109;
        Mon, 8 Feb 2021 12:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=wPeBQtYF40N/Lei6nnFszabJ3Rn1poOA/5EWDzuaZS4=;
 b=T2dBJDH1luXPW5Hpj3j+npZnIT0agJpOSln5R5im/jGqNP17z2J2BW9gcwQaLnkC9Cnc
 8owwMYj6altIWRDZLJZ/bseOsI7t1YPIhWqNwuZkJQx3zH6qsDa4eWLQJBZXmDF858aR
 ISJBQGwt0fI2vKgPSlG4UNGOXLOvfJiVQo6jggLHbOEH6/CPxlA78bFIdkmaFTmHyxPW
 d3aeWEZO5nib46JyV250OTxB4uX3IN78l+X3SZcPJMnHJqPZSvSXu1z5P9eatJD0FZRd
 Xj6Y6au56ZUZnvqcORgLqUUG8VgeTnj7+XL45dDJ5/iqWJjjXr6ZL0Ic9LtaUieh/8PU 1g== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 36k0qcaq1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 12:55:55 +0000
Received: from sarge.linuxathome.me (unknown [16.29.129.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id C47495B;
        Mon,  8 Feb 2021 12:55:53 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     kbusch@kernel.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Date:   Mon,  8 Feb 2021 12:55:48 +0000
Message-Id: <20210208125548.556931-1-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210104230300.1277180-1-kbusch@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_06:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 mlxlogscore=505 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080087
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Acked-by: Hedi Berriche <hedi.berriche@hpe.com>
Tested-by: Hedi Berriche <hedi.berriche@hpe.com>
