Return-Path: <linux-pci+bounces-20858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023B4A2BB9C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 07:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15ADE3A9651
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 06:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CAA176AB5;
	Fri,  7 Feb 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h5901ET1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE31155321;
	Fri,  7 Feb 2025 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738910393; cv=none; b=gmQXrNjOsJ0EIdAxjZvFvuF5B/2scPxh7tmEBNyGIsJq73qqnpY52qzpYctzwMUNRqe8+e5mUEsygepZ28Q2lOAoWwqQpj7E9BWzhwyzLHrEh4FSXwUCVBeFbsv3uT/95CVK/ukT1G3nWFYo+NvOpUwa5HKvPvjDmW2EqSiEmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738910393; c=relaxed/simple;
	bh=mZf+64j7IJ9OcN720VTUhKgpoeEI3CV5TslwobD69Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jL4dl8rYNkOKx4lFff0pMvX1FXS+6fkaGsUGS+QhxjE8kMUFAk9OxsNCZVFR04TBVG9nwI2GsJj2jeBqRR4fnyxCMXUG0+iY8Fl2RvFtHuvzjG145mybVjB95ZtTUpc2/NLEO+m2VDimC/S64rg6uT2Pt5pVaqLT/wyylb4n09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h5901ET1; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738910357; x=1739515157; i=markus.elfring@web.de;
	bh=Q+GMZrWbQPeFgGXVAUNcUDEPcQrHqKVSUyxOWHSP9pY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h5901ET12iU/tY8yrJpVzEwLOOpslR80K8iIrwX5CLCoEZPnmwegULl749/j5Q0c
	 P4j2QZGF9cidayGnaYtFMCqPcguATqTAhEWDm24TjX5o3pSYhVO4hNxax4q8Evtw5
	 h4iHJsQQA0/RrxHwwhbkr0byfmSl4eriY8acMv0S7/FuYGjH9FMmA2saFz9Ff5bId
	 p4d05bBXZoyqvbFItIpCMesosoQGPW9cexJofrr+sNipspc3ZENOeK/xbXUjWHarJ
	 6TDD+uY7vY31vvnuzx0M5ehw3W4WXSTkcdFM72EBNwPapnl3QphDFceSpKp22hojf
	 YmyWFBDxATLNGwrgQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.29]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovjQ-1t4BFi4BuY-00gzab; Fri, 07
 Feb 2025 07:39:17 +0100
Message-ID: <60c5504d-341f-4ce5-b337-1eca92a9506f@web.de>
Date: Fri, 7 Feb 2025 07:39:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
To: Bjorn Helgaas <helgaas@kernel.org>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peter Zijlstra <peterz@infradead.org>
References: <20250206202654.GA1000968@bhelgaas>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250206202654.GA1000968@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ptz3nnZtmUVmcg1qEZL/aod4GKTb9kszv30HNUilffQRioTZtjn
 N26Yiwfdzw2FW9CEUkbZycLr0hf2IuFw592zSvETmERrSVEMTpnwV4JBuAInsHpb457OW8+
 p3rrr4irZZlF3LUaur/uuh+tVrFCylQ4iK+Nhupp7RkqE27DBMg5FNcgLugsMMTktox63CX
 9zNkbpVV7ftDJ5Wh5NkrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+JDvlsTy8GI=;za+YhPRmymZVqd3v58UcuzexL2K
 C4I2tvcEOfrN1BlviofhFXm6NRQ4JhVjkGDi98kJ4okJLyuGaXQb3EcDkOb3WXIJ9XYefHoLa
 9U2Z8ABxy4RnJ3aqMiieMZkRl9SfME3KiKjL+sgnQeK3sVoymkzNdrPJ92wxXNkYwbw0ubuG5
 xP7/OLJ2qw5vZN6CkPyLL2v0+AeHVSbcAPuiL2Oek0lyv3S+tS0hdJUEc1vRGEFK+uNoj6Fm4
 GQCgE/F8SzNnoeOwFhjeZbIn6BQrXsPT8yATrPG8wBd2I5zEvgWh7Yi46T2zXL7GsQOBrcjN8
 4BNd8mAa/mjBE12lMbA6qq4tNPq/ASSCS6Wb2kUDpV6wIKWLkiG8Aki/3UMMFfw663c4Spn+3
 As2Gf+fK11jZzdlcaajI75lAujLcfcfUT7OFPoGyz+CvdloP1/vfhvzgOcAjWqzn8v47/wbWP
 3Ga+gcs5xk3c+BpDjE+uTOXGByIHhqMrAt/+7YbpdnDZyfmYsOPdXBsLJpoocGZGMH4s56jJE
 9chQojhyjuFG0NitOx2WIsxdW1uB1rphL26N+lVm4Z7pC6np8XfZMhfhch2ADLXYmqm50UqDJ
 ifchxbISjN/0HlXGwu+Di4RPMzB9PjYi1devvSya4mKvl+ImiDxkbUi2AijNej2aOWiH2BdWK
 vW8OHE0VAF41H7GVBGtO7h6vig7iVJh9DBT1ZM7VwaKRBsBGzAED2/zR83WJ2BRxPlT2x6CcF
 zWuZNsLieDpXJQy7bB8jWQ+t0bNg8DyEdL4razsNm3lA7g9mjXeDn3aYzbX5xy3wjAvUg22MH
 ZIEFmzKvUwp5UW/tw7SytCJd3cmSDuCPOv4yFs5EnBe2DI9rlxpOrC1m5K+EX8Kez6x1ATbj9
 5ly6B4pUkmkoIUYPHjRUKl22ztCMq4azsdgU0hPWI6+JefwYldLOxS4NCivRJi9PSe37oMKcY
 A1ZWaYBTzo6IzpQZUmPviIS3MnalUzJ/AjH1YQIXPqGDj1qnUmfPh0WyQKAFU5BOkT4b4HIEX
 7EvOvaTT8jR9R77WeKe8q1jufd1TQusnqKQZXD8lVxfp3G4cJnVSgT0KhgWhiqV2gyiRwEPjp
 9tcqWfKmqcgHje1mLUpSlKk/ZrldyBGdXiRm+C8RYgO0LX5R1oMD6JOja7X2vvBJ+vg/ypPuQ
 4D9lxu7szxj9s9xghHj4QjiqNYoVIfa/gEmwo2PLoakgdvg8o3Tsu3hwilIC0MAjX22iKldP0
 F7D94h8oIVsYZ9lR/LQDPSkMoQqqZPKqVaOf6Xjr75MGzO/RZuVATr69cawJxNo6EJBowHuw2
 S4rTrNRMNZfof3kQgL1ZxEPJSFwzvw5LKUzujdM34niir30uCzCPlLoaDSN4V4G49uyuXAuiV
 7pr8x2Rrr5Hooop+SHovwKVH0DabY+Yzh1ZpxeLiNY3AUJKuFjhaUI6Xe6ZjKZlB1tIJxZvCX
 5tGTTeg==

> I don't *really* like guard() anyway because it's kind of magic in
> that the unlock doesn't actually appear in the code, and it's kind of
> hard to unravel what guard() is and how it works.  But I guess that's
> mostly because it's just a new idiom that takes time to internalize.
How will the circumstances evolve further for growing applications of
scope-based resource management?

Regards,
Markus

