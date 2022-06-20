Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790C8551303
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbiFTIjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 04:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbiFTIju (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 04:39:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B7DEBC;
        Mon, 20 Jun 2022 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655714389; x=1687250389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vhTeKp38Tk2PFIsViYP3wmyYQbCju0HZQr5Lx6YcRLE=;
  b=Y3nV0GPz6RQVyTkzTAlEPSpefu/N2U/hdxmtMW/rRAZeFfxwAdTvauOf
   3nvlyELJAhFCkpWbHhGR9Cj0IBYzpP5LX6ChGldqj9bP6156fuhaq/yRw
   fYwW7SgGoaHYbO3Bcn76RZw3Uwr6OqGzBqaSYsw1JlBiz1esGoeFM/upg
   pTASA6BJSoM3sbihgCE9vRMbbfPq28f9fELrZA88vUhzMiZPhHkNs2dno
   3W9qtgEr2I4D/8MAoHalT7e/0KmjAh3U/0Oppdw0J8lu48aNUzQAmwdwr
   Kck9CdCCUtN1xBfKsqG0jpM7mg8OZWC1QsqWcwfY6r48L/nMV/mB19DTP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268559171"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268559171"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 01:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="729280800"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2022 01:39:48 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 01:39:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 01:39:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 01:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dosJSI2VMt1p1OM3NONcCgXnLPysLN02nXRMYcDUd7fVjSrofYe2cQyZp64y5EQjcTvoe6Jta8ihAn42tmU94CEmTCgfrhM1KZwJosJt8Nt7U4+arkO0Gx4/kWvUt5StlPUKHvsgL0bRrVNJPthb15hFD0a5wMxe/aqc1UmJ7hd6LUC6xh9zS2oaDdse3QjGGeZlvz7IhH53on0tKxJjhgmo8Te2EG5FJiOenQHzbsqKnDpCpY1kpNgicw19mKL5b91fO3SkkRQeikujwr2kaKeSThOVfn2OxILdLmSr3spMbBU0uFjmfvGyfsEszKHNO0CXobHdj9XCTbaPuY4EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNp6LeNpcY8vNt4Z4oxg3Qric9EqZolOE+97Db/NYDM=;
 b=ABql1/02OYdh9/oDKTaNXQNu5d1wVZbPoDCvrFBLd3SXkON9ZRgo76G/DMwRFznJQXOLjrPP6flMuRw4FO/6Vcm7/o+0CFxoVIzgs0Wxhl1MfkL93XH4ztDCF1wby2arFlhAlbLOCKr0/9KurkW65FmPFZCeIC+PUpXSaWhspQRCW0oiy1D6uvPwriVXNSF/oxnpLuwjRZ8wdxuXpR5IaX52csMJTgAn5BZMfmu9j0KmT3VPFHIv8zDRr6CP/65619QtyBulq/up3utlRWIcNZ7yjtmXdRQ6vYLdHxsaKY74895y/zSL1OAkPGWCUZSozITErRTMsSX9EOHABVHijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) by
 DM6PR11MB3786.namprd11.prod.outlook.com (2603:10b6:5:142::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.17; Mon, 20 Jun 2022 08:39:45 +0000
Received: from DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::353b:1d46:2ea7:706e]) by DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::353b:1d46:2ea7:706e%9]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 08:39:45 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V10 3/9] PCI: Create PCI library functions in support of
 DOE mailboxes.
Thread-Topic: [PATCH V10 3/9] PCI: Create PCI library functions in support of
 DOE mailboxes.
Thread-Index: AQHYeHZt6D1+2ArR30SGV8cAnmJrKK1YCoqw
Date:   Mon, 20 Jun 2022 08:39:45 +0000
Message-ID: <DM8PR11MB56695090626BCEC3E3E101AD89B09@DM8PR11MB5669.namprd11.prod.outlook.com>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-4-ira.weiny@intel.com>
In-Reply-To: <20220605005049.2155874-4-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23445ddf-9ed2-4e78-3600-08da52986dc4
x-ms-traffictypediagnostic: DM6PR11MB3786:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB3786D1A95574E649BA767A1689B09@DM6PR11MB3786.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ge08wtwEFNpyakQ4jYYa9YRMNSUxR7BiBKYfyJW9TeV8GZBedLxzRhRqB/DBTtUAtu/89S2KaHUOUxyMJ1S8RdMv/ZLkzwZY5JHsDejxY8y3euqNgT8TQPURZD404MmmtD3ZtzcLtPdIFTkwBXgGxZ9JCBtdRidlObYPIS2WEFvD6FEXzvNruZz/VRsgt5b9If3U69D2GJibkAHWKjeCKLFsZSSsymazqmTCwegSyTwtu6keOWeghUmZeIz3CsBIXM+NMKX0/IE4I1yG1QZKxEh2YfY7ZmEf4tPqYfS6NKPwpavHIdD2QOqEpTNjGbdmIBbINdx/zBFBzBpz/qesjNis4FFAmGfYgqlgjTqTKhmW7etWgfrX838GLJXk1GNo7f1118ljGU02jh0gHEYmIe0+pivF6BZVd7PrNeFkcpy3NfiiVOcI9WgewGMlTtGdwgAp5WegMvbu1nLYNG4a48owA3F3cAyahnV91M3fwJhaauZwkoBmQRZbnCsUEwd7n1fBw2YCLvDIVKePQDksl/VZvJoJVfCJflvsKyjOHxs3Q4rNJvASLdPkEucUj2FFqex7knEuwMpFZu4G+vKl+Y9M20gbulZe2XG28a1RVlcN4NSmivGuazZ/4334hFjznQ4172yE0rpdf6SrkMSCdMLW6yMQNH/PJjshx7+vBVIANLWRBjJpzIq8Bobsw6+pYDobVIX+Ib6P9TH1MH6jhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5669.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(33656002)(64756008)(76116006)(8676002)(66946007)(4326008)(52536014)(5660300002)(55016003)(66556008)(66446008)(316002)(83380400001)(54906003)(71200400001)(66476007)(8936002)(498600001)(6506007)(2906002)(7696005)(110136005)(38070700005)(82960400001)(9686003)(26005)(122000001)(38100700002)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eWv7Ihq7Cd7ywJOj3RBBSeW7SWZJI9eAcfO9d5Wm2uAPwTZDSyQn/yI5AkA2?=
 =?us-ascii?Q?B7ZoDrKJ4JNMqP3mUJK+lpdmQWaIwVJTqDHeea9MPBEXOYWdox7+NdPWnue2?=
 =?us-ascii?Q?2d4IDjIuMsFBhXFmhyLq+iiwCHlCsmTt0ceueluwjDO6suzQ3ryruY6pyB6Y?=
 =?us-ascii?Q?0CCiVzFJlr/Tgb0UskvJXeTVVreB39QxqLrhrNQRmQ4LIYvhru5ON7Vgr15+?=
 =?us-ascii?Q?qTEtTfBW6IpIieUfSmzSBR5qw3pPlaxL+KWj3c5/ml07cN8H0tG3Z6uRXdLT?=
 =?us-ascii?Q?LJCuKAD9rDBmtfFG0zLfqI7XjWIRx0ZHkIrb1Vj2DChT63O1oyx4jiMkKYor?=
 =?us-ascii?Q?xrcvFBrCr3f8t8QJtQv83y/5jhxc7ZulPzihUSO8HWFX88mHFSMHPF4FOP4U?=
 =?us-ascii?Q?w7NebOHg3hcrGhshRXCwx0o/1MZT/GctBXe3FvvNPm6qJr8ykPZXQNFXlD8u?=
 =?us-ascii?Q?KNyRUSR+rYE+QsAO9Wqehd9RXl4s1AkQefZjajL+NGUZYP2N/4P1Ph7PxA7o?=
 =?us-ascii?Q?4oFK1PlEPkKTmtlMmTpJNktqmgTnFeGaDK2llTecpRxVS9TV02g81HYz7kOL?=
 =?us-ascii?Q?4rcy7jqjt0on74c69tnZRYxjJUFg/UcPCcUoXp+DbaVbV3wA3bLxSZoAmbl5?=
 =?us-ascii?Q?SaZFur0SLwRlQlhVn78kUrPOklMIJyKVW+PVStJQL4tOS/MTm3vjOzVCS2nY?=
 =?us-ascii?Q?YYLZDLz1LmMuj1vPOWvijkc1Ah7CDcye3Auwc/WdPEF7+8ZrCOwGBldGgt+v?=
 =?us-ascii?Q?r6TO7ZAwLtfyaNCEsI4tlwO0voCzDZVgXuB60TF7SYn/ylF8DLJas4yxuEGq?=
 =?us-ascii?Q?VlfNgs5xjQ+JzDOR07nAIT4Ey7P7I98sqbjB+Z818neDznQ5DscEzC2AGqFF?=
 =?us-ascii?Q?pG8626sibQarZuJX8T6zAOFscf9SkOkQOLqWEqjsA+wt+6iqzNXXOvSjqm6d?=
 =?us-ascii?Q?zk6WzOyFl1vux/PKwCVbGuvdzey0Cg6lalIs52OenEqs8tMsxkwy/Crg4UXF?=
 =?us-ascii?Q?CUDqUsVtTfbusYvLfvVei2idEtGHQaxvh7SOHw2gqPTea1PXJl6/pnNfpv8a?=
 =?us-ascii?Q?zLme6bgOZW9CZgFucmGvnhVh61OocTHv3RMq8L4JFFuIZUtxLVzxnl9Ea6/n?=
 =?us-ascii?Q?cjnKJw9fjd2aCQgkNE9Q7ncZalTRdaQs+4s1Q48jqc0F8bgF1CqxPnHTzhnB?=
 =?us-ascii?Q?8jHEOCOO/KPecHrRKIgq0LvqmNJpWERECxil3CnnV4ZNVwI6pv5+1R+hirZv?=
 =?us-ascii?Q?0V0eO0s35Y9jwyNCsuzW/kdtU0AfgNolrMpchhjjluF4nNi3WXxFvMOzQP8S?=
 =?us-ascii?Q?hoeVuU9XKMUfjycqndk+573CPzqbCf315qQa/YdbKk9zqp9dkweNlEVDWfM8?=
 =?us-ascii?Q?HdH6KIcI3xrX3tqGRciHOX1ChtxC3dZp/RWtUE9fscJUAKGYKDiV81LjfaJg?=
 =?us-ascii?Q?chsFWwCjLK3PVH5OtEFSZVWW3rUZgk8EHdlr0ygQdqQKY7x+gyWOMpd9vyIO?=
 =?us-ascii?Q?4oCkn/R4bcxi69s+rnKnDTcDMC2PSRwSjYp2l1JrZt92S88o9g4hpJ0HG/Q5?=
 =?us-ascii?Q?xfT/eoduFO7F1Q+JWGuPXEM9yTqrSSOXqk81QyrJ3zrc4cWuEuf9OvmQ88Zv?=
 =?us-ascii?Q?iUGZVyui5QIu3+9sOTVPNRjuxf6tR9g3SZsJD/XdlYYXJ9cDAJmNvhvvz2ck?=
 =?us-ascii?Q?Wf6EkIGmcfJ3ndrLAU9m186EmHRaxqat7cjDYP8oQTiz4Sf6jPoAFo2i6cLY?=
 =?us-ascii?Q?KKdEixVVdg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5669.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23445ddf-9ed2-4e78-3600-08da52986dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 08:39:45.6272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjwsuJxu4us/ilP7duHkmY6W51xZgH+Vy4jD3QMmVa/OxSC5oRbffdj8Tb/VSBYKcWmBIRFhJaTnQWOJYqk0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3786
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: ira.weiny@intel.com <ira.weiny@intel.com>
> Sent: Sunday, June 5, 2022 8:51 AM
> ...
> +static void retire_cur_task(struct pci_doe_mb *doe_mb) {
> +	spin_lock(&doe_mb->task_lock);
> +	doe_mb->cur_task =3D NULL;
> +	spin_unlock(&doe_mb->task_lock);
> +	wake_up_interruptible(&doe_mb->wq);
> +}
> +
> +static void doe_statemachine_work(struct work_struct *work) {
> +	struct delayed_work *w =3D to_delayed_work(work);
> +	struct pci_doe_mb *doe_mb =3D container_of(w, struct pci_doe_mb,
> +						 statemachine);
> +	struct pci_dev *pdev =3D doe_mb->pdev;
> +	int offset =3D doe_mb->cap_offset;
> +	enum pci_doe_state prev_state;
> +	struct pci_doe_task *task;
> +	u32 val;
> +	int rc;
> +
> +	spin_lock(&doe_mb->task_lock);
> +	task =3D doe_mb->cur_task;
> +	spin_unlock(&doe_mb->task_lock);

              I don't think it needs the lock protection here.=20
              No matter "task" is !NULL or NULL, it is checked before it's =
used within this function.

> +
> +	if (test_and_clear_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags)) {
> +		/*
> +		 * Currently only used during init - care needed if
> +		 * pci_doe_abort() is generally exposed as it would impact
> +		 * queries in flight.
> +		 */
> +		if (task)
> +			pci_err(pdev, "DOE [%x] Aborting with active task!\n",
> +				doe_mb->cap_offset);
> +		doe_mb->state =3D DOE_WAIT_ABORT;
> +		pci_doe_abort_start(doe_mb);
> +		return;
> +	}
> +
> +	switch (doe_mb->state) {
> +	case DOE_IDLE:
> +		if (task =3D=3D NULL)
> +			return;
> +
> +		rc =3D pci_doe_send_req(doe_mb, task);
> +
> +		/*
> +		 * The specification does not provide any guidance on how
> long
> +		 * some other entity could keep the DOE busy, so try for 1
> +		 * second then fail. Busy handling is best effort only, because
> +		 * there is no way of avoiding racing against another user of
> +		 * the DOE.
> +		 */
> +		if (rc =3D=3D -EBUSY) {
> +			doe_mb->busy_retries++;
> +			if (doe_mb->busy_retries =3D=3D
> PCI_DOE_BUSY_MAX_RETRIES) {
> +				/* Long enough, fail this request */
> +				pci_warn(pdev,
> +					"DOE [%x] busy for too long (> 1
> sec)\n",
> +					doe_mb->cap_offset);
> +				doe_mb->busy_retries =3D 0;
> +				goto err_busy;
> +			}
> +			schedule_delayed_work(w, HZ /
> PCI_DOE_BUSY_MAX_RETRIES);
> +			return;
> +		}
> +		if (rc)
> +			goto err_abort;
> +		doe_mb->busy_retries =3D 0;
> +
> +		doe_mb->state =3D DOE_WAIT_RESP;
> +		doe_mb->timeout_jiffies =3D jiffies + HZ;
> +		/* Now poll or wait for IRQ with timeout */
> +		if (doe_mb->irq >=3D 0)
> +			schedule_delayed_work(w, PCI_DOE_TIMEOUT);
> +		else
> +			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
> +		return;
> +
> +	case DOE_WAIT_RESP:
> +		/* Not possible to get here with NULL task */
> +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS,
> &val);
> +		if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +			rc =3D -EIO;
> +			goto err_abort;
> +		}
> +
> +		if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
> {
> +			/* If not yet at timeout reschedule otherwise abort
> */
> +			if (time_after(jiffies, doe_mb->timeout_jiffies)) {
> +				rc =3D -ETIMEDOUT;
> +				goto err_abort;
> +			}
> +			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
> +			return;
> +		}
> +
> +		rc  =3D pci_doe_recv_resp(doe_mb, task);
> +		if (rc < 0)
> +			goto err_abort;
> +
> +		doe_mb->state =3D DOE_IDLE;
> +
> +		retire_cur_task(doe_mb);
> +		/* Set the return value to the length of received payload */
> +		signal_task_complete(task, rc);
> +
> +		return;
> +
> +	case DOE_WAIT_ABORT:
> +	case DOE_WAIT_ABORT_ON_ERR:
> +		prev_state =3D doe_mb->state;
> +
> +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS,
> &val);
> +
> +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> +			doe_mb->state =3D DOE_IDLE;
> +			/* Back to normal state - carry on */
> +			retire_cur_task(doe_mb);
> +		} else if (time_after(jiffies, doe_mb->timeout_jiffies)) {
> +			/* Task has timed out and is dead - abort */
> +			pci_err(pdev, "DOE [%x] ABORT timed out\n",
> +				doe_mb->cap_offset);
> +			set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> +			retire_cur_task(doe_mb);
> +		}
> +
> +		/*
> +		 * For deliberately triggered abort, someone is
> +		 * waiting.
> +		 */
> +		if (prev_state =3D=3D DOE_WAIT_ABORT) {
> +			if (task)
> +				signal_task_complete(task, -EFAULT);
> +			complete(&doe_mb->abort_c);
> +		}
> +
> +		return;
> +	}
> +
> +err_abort:
> +	doe_mb->state =3D DOE_WAIT_ABORT_ON_ERR;
> +	pci_doe_abort_start(doe_mb);
> +err_busy:
> +	signal_task_complete(task, rc);
> +	if (doe_mb->state =3D=3D DOE_IDLE)
> +		retire_cur_task(doe_mb);
> +}

