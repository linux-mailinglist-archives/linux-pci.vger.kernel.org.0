Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E853934CDE9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhC2KZh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:25:37 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:50596 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231787AbhC2KZa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 06:25:30 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 584DAC049B;
        Mon, 29 Mar 2021 10:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617013530; bh=4tYdZoz99LqS1rTW0lx4j6B4kPQvYiFg7CenSpR3B6E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=V555atbemZl2lP2ulQmJ/OoxK1o9+PlvEXkAGYxY6BXlunOP8IAriH/J1JKH32usg
         Ww59tBH5KxhTjru3Cb654jiRVHAHSScA1fk4sC9xdNh5AIeKEBTijXnp+ZiD8UEtEz
         FdqZszWB3oxcu3Ajp7cgfLyPXG25ns/+w6xdjgrq/FqgA0AH/iZW3nzWqn4kJ07pNO
         5nQPPzrlQrc8iR6k4p/4HarsinESP0jrGWC/MOyuDj86OFr9LjDvYBjo314Z4kPmJ1
         oe6ZVaIQG8ldxWJaXVKr2UItcJNnBtkh2kLyIFNvJlEv8PWjBwq8K8UEgoR3zoYch5
         ySI6FE771WV7A==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 14353A0084;
        Mon, 29 Mar 2021 10:25:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 419D4400E5;
        Mon, 29 Mar 2021 10:25:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="WV5fSzup";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwN89B/Cylq4MCaTR+LVTF4+9xIliSnXu7LJIJyMXDwQIq8NM9ZYDEodrH4eLlEGrtLJZtkdhwK7JY7prlCxabaiO9bI48/fwY66P6z1IJQ9kaY2y4nQCzX10aIOmHH/nOs5De+dYtIgWLSfzbKySHnM144WMcqlwSQUpsXriVI3UhYvEsMpmOEPGio4JRWNq2Mys0QNogedv4G3gPxMnHkPNPfuf4Z4fXrUgjSR+/suXJEyNx8AX7H51lKBqdhKAwPpVCma16m+WL7s1Aq+WrIPvQ74/wMbaZTi7tHcivALAXMTBJN+JwD4nMVHPVShAhINp/LEMp95nc3RZwbrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLSzkSUbc/eaqpbSwRwEq9dSG3NdpyrvI+lTx2k3GMY=;
 b=L7seuVWtGot2rEkY/LXpsmST9tqWzo9dcIVsJMuC4ixexQRkHDFQ6YiG3hUs9zb57IdJHMmHl337b3/pR+tDt7uNOF0uCSPSEVDeU2ykdgTQnMZBekVjlQ8rIr3AfwtWnBPi68jdhoJ1ju8qabtsHg4zNBQ/dWLU2w8s5pVZBswwIbwTZXSa09djV8nk9PqQzyhvT2ylft00BDRIzcALJ6I0xbFpVZ/Yl2fSwayJnmxSggfDBo5fCqWzVyq/EiVkvrSc3zA4U+XU75xIMHSZvEHS0Bg2JbT+rfXk34Pr6qqtuRcJOfuevoIi6v/pQhX41AMpzo0npw0cCVElkasVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLSzkSUbc/eaqpbSwRwEq9dSG3NdpyrvI+lTx2k3GMY=;
 b=WV5fSzuprRG2nEm4Es99V0qrqmoLtU1UlG1+4PQYUgYKXad9amk+1gpyWwwHdu7gVcDhHwmta/JsLvQfUMR8KwGkrQ2E+2ghBCeNopArX/4oZN+OW3USuAACQvjxZVgpCZhsxnh4d9veYiRD+SubLdz3+MifW4csNMc5mCrj6UY=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Mon, 29 Mar 2021 10:25:25 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3977.033; Mon, 29 Mar
 2021 10:25:25 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: RE: [PATCH v9 4/4] docs: ABI: Add sysfs documentation interface of
 dw-xdata-pcie driver
Thread-Topic: [PATCH v9 4/4] docs: ABI: Add sysfs documentation interface of
 dw-xdata-pcie driver
Thread-Index: AQHXJIJG60dvF/r8ckWOtxY3dz7xnKqavdSAgAAAuiA=
Date:   Mon, 29 Mar 2021 10:25:25 +0000
Message-ID: <DM5PR12MB18353C0E6935F94C457F9595DA7E9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
 <5840637a206dd1287caf142a0dbedf0dac9ccd48.1617011831.git.gustavo.pimentel@synopsys.com>
 <YGGnC8LouF+paZ6G@kroah.com>
In-Reply-To: <YGGnC8LouF+paZ6G@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1?=
 =?iso-8859-2?Q?xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?iso-8859-2?Q?NGJhMjllMzViXG1zZ3NcbXNnLTExNDBlNzI1LTkwNzktMTFlYi05OGVkLW?=
 =?iso-8859-2?Q?E0NGNjOGU5Y2YwNlxhbWUtdGVzdFwxMTQwZTcyNi05MDc5LTExZWItOThl?=
 =?iso-8859-2?Q?ZC1hNDRjYzhlOWNmMDZib2R5LnR4dCIgc3o9IjE3NjIiIHQ9IjEzMjYxND?=
 =?iso-8859-2?Q?g3MTIzNjA4MzI2OSIgaD0iNERpL3QzajRrVUZ3bGMwV0xVZkNHZllUVUsw?=
 =?iso-8859-2?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-2?Q?NnVUFBSFlJQUFCRi92WFRoU1RYQVVhTHhTWXBjK0FWUm92RkppbHo0QlVO?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQUdDQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUFnbk1odXdBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFKNEFBQUJtQUdrQWJnQmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2?=
 =?iso-8859-2?Q?tBYmdCbkFGOEFkd0JoQUhRQVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQU?=
 =?iso-8859-2?Q?FHWUFid0IxQUc0QVpBQnlBSGtBWHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1B?=
 =?iso-8859-2?Q?WHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWmdCdkFI?=
 =?iso-8859-2?Q?VUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0JsQUhJQWN3QmZBSE1BWV?=
 =?iso-8859-2?Q?FCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhBZFFCdUFHUU?=
 =?iso-8859-2?Q?FjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QnRBR2tBWXdB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?iso-8859-2?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUhRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUNBQUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUU?=
 =?iso-8859-2?Q?J5QUhRQWJnQmxBSElBY3dCZkFIUUFjd0J0QUdNQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQU?=
 =?iso-8859-2?Q?FBQUFBSjRBQUFCbUFHOEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1?=
 =?iso-8859-2?Q?QUdVQWNnQnpBRjhBZFFCdEFHTUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?iso-8859-2?Q?QUFBR2NBZEFCekFGOEFjQUJ5QUc4QVpBQjFBR01BZEFCZkFIUUFjZ0JoQU?=
 =?iso-8859-2?Q?drQWJnQnBBRzRBWndBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3Qm?=
 =?iso-8859-2?Q?hBR3dBWlFCekFGOEFZUUJqQUdNQWJ3QjFBRzRBZEFCZkFIQUFiQUJoQUc0?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUdFQWJBQmxB?=
 =?iso-8859-2?Q?SE1BWHdCeEFIVUFid0IwQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFiZ0J3QUhNQVh3QnNBR2?=
 =?iso-8859-2?Q?tBWXdCbEFHNEFjd0JsQUY4QWRBQmxBSElBYlFCZkFERUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VB?=
 =?iso-8859-2?Q?YmdCekFHVUFYd0IwQUdVQWNnQnRBRjhBY3dCMEFIVUFaQUJsQUc0QWRBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?SUFBQUFBQUo0QUFBQjJBR2NBWHdCckFHVUFlUUIzQUc4QWNnQmtBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQU?=
 =?iso-8859-2?Q?EiLz48L21ldGE+?=
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3fb758d-06f8-4fba-0f49-08d8f29cf7aa
x-ms-traffictypediagnostic: DM6PR12MB2988:
x-microsoft-antispam-prvs: <DM6PR12MB2988BFDEF72ECC61892F29D1DA7E9@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GxBg1afaaUA1UmrPwGs4lR/nlpzzKyWOeZT9HIRZYWlPO8j/jdFVxOT4iT9pDgSVpk7hDir7Lp77bFprHoSVnGXuF3hycDPyYoDt8tymHLBWW8KwydtdajeydNTKUo54qwGM2XtWkHpz2OMrc4R51B+4Xfu33+6JjxzDjmHT35Xt4FdGwT1G/TsIdBMvo4CFR0CueHAIM+AwygbZgDCXffWpMTSRN74gTFSYnwU4yuaxJSYUVtC9pNcasgbCShPr3BkoeMUf0py75HvTugXmrbav41zU4oW2DCQYBsY1fvgz8VaAaTbai0Co9Ap60syek6hvInO2ZVAYN/IrHIfFpXlXhuRd8JWDFOuXTaoPC4FUTCiikq31vo1YFIoQaGg1JBCS/TK+TmS30CquQ/Z8TE1E6APV0H24pa4HusBMlc9ZpjJmftfufG+mIU+PfHnBLkUJleYWaB+qkAmwGSSdyKtQ+PNdJ1ML5+kdaIgJ1RVAj17JKuK8aHxKOYhisNpBIQbJ3qK9drnScrx7XkZ0J+hnsyuV/vaRsSfUBALdfRt1C0N0JiT6WdXYWw3qeYq45R6eCfLIZ6i5xvuY1PRcPxRb64wckW3+Gp3Rh3/RxKh0yCQIjx5Zd74+INtpsKCJXb50SYv0WaOK21e4T1z2wsEpa8RQJwFHjA+2MyDhvjA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(346002)(366004)(6506007)(2906002)(7696005)(8936002)(71200400001)(8676002)(53546011)(33656002)(55016002)(9686003)(38100700001)(478600001)(316002)(54906003)(186003)(4326008)(64756008)(52536014)(6916009)(26005)(7416002)(5660300002)(66946007)(66446008)(86362001)(76116006)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?q/sLU1RJ5kJQyhr2ophIlDnaJ8ID1pz99qhhMlf7+Wm3qvZjlZiHDk4DL0?=
 =?iso-8859-2?Q?QZQQFXIhuMephydO2YpWxGCnmzVnqnMuw5TD+nURBkA59/r2oUzuET3v5L?=
 =?iso-8859-2?Q?U7MxoUrxV6fxQmMOo3QgvhV6k4G6E/TQEVfrQsF8m2gfoNzZLA784dvL0h?=
 =?iso-8859-2?Q?IeCeywXp2LdDOjDF3v8Ug3pEiearxuMHlGU8GFrzjd060eN95muOLqmiL4?=
 =?iso-8859-2?Q?pyOifDP7pcEXXP/VPy7CO7R/e1DWjsfGklatXXSw0CG22VUzo7XWW4bBAU?=
 =?iso-8859-2?Q?SHSgwZvRuq0XeOd9l2KsC/fGVt+Aybr+FkBwq7BRtzsAd59H4FCvKaJmxO?=
 =?iso-8859-2?Q?yv56zFfrESI9Se+Wlf9fJZbFBuCQWSp2eyowKfnP7If39W1zwHh9eu27Qt?=
 =?iso-8859-2?Q?VzJD74smVNEvWqyOvhpLitzeXf9ttOs6CSofmjFlnIO9wE8+I7ZuhhC5A8?=
 =?iso-8859-2?Q?2PqOawIWkmbwpB7uuhTg6lESTAembPuI2yjnjSqDaUEcKWgwbFQnuF6Di9?=
 =?iso-8859-2?Q?G4uIm18u7MNfOrRfDCA8HhbbGhinEuH0ir8XQN6xmKE56HI3Z8Fr1c0lY1?=
 =?iso-8859-2?Q?rQ0aiHKu13Vi0/LE7ODfBMvLxTRY0ms2XAEP8szJ60IROe1oadtLJyiaXu?=
 =?iso-8859-2?Q?3o/XXfbRAnJVyHNZ1cXKfcYW79uG2xL1GlWL4+2DA38PicTOXz7bN89pwv?=
 =?iso-8859-2?Q?SH6zN1CPaUJi8L9VZGQzouqW95vIMuGKw2OjitVsjvA+HWI/8kTZFRayxH?=
 =?iso-8859-2?Q?mVp1nzZUxHNft56jUgXhDjZFKz74GlsEwNVlZjmja+BX9YhXw1JF7RAMsb?=
 =?iso-8859-2?Q?uF9/AY+sMscE1lCMRkojjnfUy++TBMmiiJRZVj/efWhk10V8hNioLJvw9D?=
 =?iso-8859-2?Q?tC9JlP1xLh/9QhRYXO0Oz892vbdSsu18JeNKkKZarlEj1KGlz5p5+JWpCE?=
 =?iso-8859-2?Q?1QI3ZyrP+V6zyAMY7b8DnL8+JCbIMEktpEZnkxXZtvpXyr6VkTrbEvGKwu?=
 =?iso-8859-2?Q?eJFnpXr+HSw4ryMvnaY5r9I3ct7lhBuQWb7RY+fxZm1XfYy8tKdCN0pvge?=
 =?iso-8859-2?Q?wogpYdJraOGpni+tIFnQCuG4lGPFGPHzBqksDHwGf02UqsqEr88MA+8uPs?=
 =?iso-8859-2?Q?nEToY71VdCAGdrcv4u7Ksmpqo3AdjM6kJAeUwzsWV0cG4KKuJHBs9M4r8F?=
 =?iso-8859-2?Q?R32iqqysjymyxfXhWlLG4GWeul/GzWX4LLKWmrRMWKSu6hONPeW3Mpof2P?=
 =?iso-8859-2?Q?oHTmjO6KRPHyJVtOKqt2TzUiYnUVzaGRuLoAUFJZLd8ZjD/HR3nu8uEPsk?=
 =?iso-8859-2?Q?HzUi87jweTNabdZ2LKY3t1MRnJ4UJ6Ia/CiTS3uRJyOD4DQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fb758d-06f8-4fba-0f49-08d8f29cf7aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 10:25:25.4943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaGeUKMsg8UvRXQ9U1+SH7+bwebApqxFWBZNvmgUItVIYTiSbXwymWkpsJUzp2HuSIDlz2KDAN5HPQxJDTzU/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 11:8:11, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Mon, Mar 29, 2021 at 11:59:40AM +0200, Gustavo Pimentel wrote:
> > This patch describes the sysfs interface implemented on the dw-xdata-pc=
ie
> > driver.
> >=20
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  Documentation/ABI/testing/sysfs-driver-xdata | 46 ++++++++++++++++++++=
++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-driver-xdata b/Documentati=
on/ABI/testing/sysfs-driver-xdata
> > new file mode 100644
> > index 00000000..66af19a
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-xdata
> > @@ -0,0 +1,46 @@
> > +What:		/sys/class/misc/drivers/dw-xdata-pcie.<device>/write
> > +Date:		April 2021
> > +KernelVersion:	5.13
> > +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > +Description:	Allows the user to enable the PCIe traffic generator whic=
h
> > +		will create write TLPs frames - from the Root Complex to the
> > +		Endpoint direction.
> > +		Usage e.g.
> > +		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/write
>=20
> Again, this does not match the code.  Either fix the code (which I
> recommend), or change this and the other sysfs descriptions of writing
> values here.

I've commented about this previously, but I didn't get feedback on it,=20
therefore I assumed that justification was okay.
I will change the code to accept only the "1" input on the *_store()

-Gustavo

>=20
> thanks,
>=20
> greg k-h


