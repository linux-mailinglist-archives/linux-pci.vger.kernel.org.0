Return-Path: <linux-pci+bounces-1663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6E78241B5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 13:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3921F2519F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502401EA76;
	Thu,  4 Jan 2024 12:25:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA921373;
	Thu,  4 Jan 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.17.2/8.17.2) with ESMTPS id 404CIq6K028017
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 4 Jan 2024 22:48:53 +1030
Date: Thu, 4 Jan 2024 22:48:52 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <ZZaiLOR4aO84CG2S@marvin.atrad.com.au>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
 <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240104131210.71f44d4b@imammedo.users.ipa.redhat.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Thu, Jan 04, 2024 at 01:12:10PM +0100, Igor Mammedov wrote:
> On Thu, 28 Dec 2023 18:57:00 +0200
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> 
> > Hi all,
> > 
> > Here's a series that contains two fixes to PCI bridge window sizing
> > algorithm. Together, they should enable remove & rescan cycle to work
> > for a PCI bus that has PCI devices with optional resources and/or
> > disparity in BAR sizes.
> > 
> > For the second fix, I chose to expose find_empty_resource_slot() from
> > kernel/resource.c because it should increase accuracy of the cannot-fit
> > decision (currently that function is called find_resource()). In order
> > to do that sensibly, a few improvements seemed in order to make its
> > interface and name of the function sane before exposing it. Thus, the
> > few extra patches on resource side.
> > 
> > Unfortunately I don't have a reason to suspect these would help with
> > the issues related to the currently ongoing resource regression
> > thread [1].
> 
> Jonathan,
> can you test this series on affected machine with broken kernel to see if
> it's of any help in your case?

Certainly, but it will have to wait until next Thursday (11 Jan 2024).  I'm
still on leave this week, and when at work I only have physical access to
the machine concerned on Thursdays at present.

Which kernel would you prefer I apply the series to?

Regards
  jonathan

