Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286992D1547
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 16:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgLGP4Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 7 Dec 2020 10:56:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:47689 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgLGP4Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 10:56:24 -0500
IronPort-SDR: BqZuJ+0gvy0LLJPbP+ToRxpzPXXbmU+7AThOt5v3EmJjg12VaHV8OEwx0DrO7PfXkmBma9JNlT
 a2a7oOJSJ0MA==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="152962714"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="152962714"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 07:55:44 -0800
IronPort-SDR: JqljrY7NKgtBF5E9+6jS3K5H6TUX6VVLbAJrVYPKj7ydBZ2garzw5f3kDpSv91V8zX7vC5AqUz
 GsC//KfhRBww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="436832912"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2020 07:55:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Dec 2020 07:55:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Dec 2020 07:55:43 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Mon, 7 Dec 2020 07:55:43 -0800
From:   "Jiang, Dave" <dave.jiang@intel.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
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
Subject: RE: [PATCH v8 16/18] NTB: tool: Enable the NTB/PCIe link on the local
 or remote side of bridge
Thread-Topic: [PATCH v8 16/18] NTB: tool: Enable the NTB/PCIe link on the
 local or remote side of bridge
Thread-Index: AQHWuEC9OnGPVEaiTUCW+4PBXB6hF6nr8fOg
Date:   Mon, 7 Dec 2020 15:55:43 +0000
Message-ID: <f39cf769993541e2a46bfe4d777ccf46@intel.com>
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-17-kishon@ti.com>
In-Reply-To: <20201111153559.19050-17-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: Wednesday, November 11, 2020 8:36 AM
> To: Bjorn Helgaas <bhelgaas@google.com>; Jonathan Corbet
> <corbet@lwn.net>; Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo
> Pieralisi <lorenzo.pieralisi@arm.com>; Arnd Bergmann <arnd@arndb.de>;
> Jon Mason <jdmason@kudzu.us>; Jiang, Dave <dave.jiang@intel.com>;
> Allen Hubbe <allenbh@gmail.com>; Tom Joseph <tjoseph@cadence.com>;
> Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> pci@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-ntb@googlegroups.com
> Subject: [PATCH v8 16/18] NTB: tool: Enable the NTB/PCIe link on the local or
> remote side of bridge
> 
> Invoke ntb_link_enable() to enable the NTB/PCIe link on the local or remote
> side of the bridge.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c index
> b7bf3f863d79..8230ced503e3 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -1638,6 +1638,7 @@ static int tool_probe(struct ntb_client *self, struct
> ntb_dev *ntb)
> 
>  	tool_setup_dbgfs(tc);
> 
> +	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);

The tool expects the user to enable the link via debugfs according to documentation. Is this necessary?

>  	return 0;
> 
>  err_clear_mws:
> --
> 2.17.1

