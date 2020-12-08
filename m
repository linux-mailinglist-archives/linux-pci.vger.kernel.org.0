Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1862D223A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 05:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgLHEsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 23:48:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35170 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgLHEsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 23:48:00 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B84kqxV039474;
        Mon, 7 Dec 2020 22:46:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607402812;
        bh=ab8TR71D8wvDMjyDs6nWrexGzGp6Fis30WChrKD0GJI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I1KcsdWfGGYKukU1vhdrJMy3dUirqKSS8jiSFV+azOygxU/WmetaeoFr4QPN7fk2O
         UxFK+NyVzyVyTqtyzzKkTiA5UZ3MYqpYSyGYUd55RbkWH+14VndD7BbKV2RBM8eASt
         vb+sJt5xjkxsIKdGHs+vPyuQAw00hfK8AW8HWujc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B84kqEQ098505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Dec 2020 22:46:52 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Dec
 2020 22:46:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Dec 2020 22:46:52 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B84kkoW053051;
        Mon, 7 Dec 2020 22:46:47 -0600
Subject: Re: [PATCH v8 16/18] NTB: tool: Enable the NTB/PCIe link on the local
 or remote side of bridge
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-17-kishon@ti.com>
 <f39cf769993541e2a46bfe4d777ccf46@intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6a493055-eef0-5722-e24b-449a11cf8a36@ti.com>
Date:   Tue, 8 Dec 2020 10:16:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f39cf769993541e2a46bfe4d777ccf46@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dave,

On 07/12/20 9:25 pm, Jiang, Dave wrote:
> 
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>> Sent: Wednesday, November 11, 2020 8:36 AM
>> To: Bjorn Helgaas <bhelgaas@google.com>; Jonathan Corbet
>> <corbet@lwn.net>; Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo
>> Pieralisi <lorenzo.pieralisi@arm.com>; Arnd Bergmann <arnd@arndb.de>;
>> Jon Mason <jdmason@kudzu.us>; Jiang, Dave <dave.jiang@intel.com>;
>> Allen Hubbe <allenbh@gmail.com>; Tom Joseph <tjoseph@cadence.com>;
>> Rob Herring <robh@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
>> pci@vger.kernel.org; linux-doc@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-ntb@googlegroups.com
>> Subject: [PATCH v8 16/18] NTB: tool: Enable the NTB/PCIe link on the local or
>> remote side of bridge
>>
>> Invoke ntb_link_enable() to enable the NTB/PCIe link on the local or remote
>> side of the bridge.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/ntb/test/ntb_tool.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c index
>> b7bf3f863d79..8230ced503e3 100644
>> --- a/drivers/ntb/test/ntb_tool.c
>> +++ b/drivers/ntb/test/ntb_tool.c
>> @@ -1638,6 +1638,7 @@ static int tool_probe(struct ntb_client *self, struct
>> ntb_dev *ntb)
>>
>>  	tool_setup_dbgfs(tc);
>>
>> +	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
> 
> The tool expects the user to enable the link via debugfs according to documentation. Is this necessary?

right, it can be enabled using debugfs. Will drop this patch.

Thank You,
Kishon
