Return-Path: <linux-pci+bounces-5520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98911894C7A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 09:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D80F1F22FEC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 07:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA839852;
	Tue,  2 Apr 2024 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="klVBU1LA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF23839A;
	Tue,  2 Apr 2024 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042184; cv=none; b=ii5reXlyQrlszFBiZfEWz8BwgChpNcmVXx1+phDQrjZ8BzwTJUK7Ex5L6YtBrPp669wwMG14FnW5mtsy09Rd+9xDnZwbNwvPCZ8ypsT+rSrLlt4aFPKu4Il1M8K1OrbolyCRbuzZ/MxLYEH+e7nyhSFhFAs8QpC2N/59w27oy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042184; c=relaxed/simple;
	bh=RDW+zwDa2CBhzAKEQWv7lUSIpXm7MGCiMSp3c7znYCA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SOH2d4nDPfLyD1NkbNtetL26YtqHVUa7iaRdInvwLdgecnJ+ScohcQtJUwrjG8mDFWkJGTI+vuap/o6xIQBvaXpa2u+QqtPMNmfsbKA1BpW5ElkLzhsS6U736Uz27k28hdyY+fepUDHjsChyXE0oUuUsoKA7Q08tHbRe9Hwkc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=klVBU1LA; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712042138; x=1712646938; i=markus.elfring@web.de;
	bh=RDW+zwDa2CBhzAKEQWv7lUSIpXm7MGCiMSp3c7znYCA=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=klVBU1LApA5mIHVuMI6quyFsihVv8LzhIcTfdvNXNyI9zDmW9vvyrSPapEuB31IJ
	 3+gzlmAlKl7UOwV4Ub4j6QZPuQuXEuLDhPpr8bJDsxdJ+c2cnpjGinpA5H6lMfztU
	 k663VM4upYOUdgzzPS3zBaY8KspXEFYk5XpVufKyOECOz7J8iPfEDlvGBVO8HHrtC
	 Z097LNP96ylALTvHfvh2x/cY6fQVwHGHAXNEFunpxRYIUJJQZkXXLBNbOBcVW1GPb
	 EcAKmE3etEOIyz1vs44vj1tNlrGo+UXmPmFhb8wvgvevnSEdimWMCqKhHRjzB+3nG
	 egtEextJn6dr5IgNcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFrxr-1s2nB70qQZ-00HLVA; Tue, 02
 Apr 2024 09:15:38 +0200
Message-ID: <e4776c82-e255-4eab-b6c4-8087e02f384f@web.de>
Date: Tue, 2 Apr 2024 09:15:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kevin Tian <kevin.tian@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Lukas Wunner <lukas.wunner@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>
References: <BL1PR11MB5271DB63688BF220D0317AC08C3F2@BL1PR11MB5271.namprd11.prod.outlook.com>
Subject: RE: [v3] cleanup: Add usage and style documentation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <BL1PR11MB5271DB63688BF220D0317AC08C3F2@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JTNDDC3fQbZw22eedVtgOny1uIqThPnTxOxFVbrDzjp4rYzGaFw
 3eJP2d0xCDlTZakMdes3GX7bxJ1ofpe9kWhpKILziqx02qyE5lICdlFkefUJaaqo1Pn+Eq+
 viv7ysn21bw6ZfmyNgTMDdwnMNeMf1OEe9Ms4Y6PmRelsZPM2hT/UgyXkfZOI4jscCZi5hQ
 3pebzI942P5GQrR5Wlr0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wqufEvOOBnU=;3sjX2UJscXMIMeiT2ovpJaBmB2f
 l9zRzPgxe4xxclVIw6AtlLYNXNaIafESCTJXewjjt/mow2bTXaXzulvshkQE4HYLinFSHG0PA
 MYydAQzVF8U/jS2Gctuyeg1hf6EB/kVPPdm5ey1Tm6muUfkSohuqTi7OhdvtK/Ml1Y2buDJoQ
 F0IjWKpOgXbxK8yKoitYUdlU6h4V5nd6O/nTB27NZtNHBa4U2pqSSTOTen4dnmSAXaCjbgLS/
 AzmpbHd3Wc8d3L1zBsY7T6tCjXji++bwKFZUR1OHawXWYQMwJ22OzVpb2zDHIPWT9I6wUfdz6
 VP3yc6Nol2UEsVhMZvjWyYoQHhLqWirsectx4sX8agQ7ipTpUUSVg5CySNY+n64lg7l/VmQN5
 gg3qSDxzuOJtUymIftZcUsJcoEcs5U8+USGYFKipJ+btRIVi0PuaDonTI4Az3MKK3rd/v2h3Z
 3ToIkQ0HxOVuJyCGCbFWFZJ9qGCyi+wFdhhJxNdic4Cx5J6DGqVmODOp6evwO0KGwTbqk4pWa
 EhT2G6fpzM9T+DzBU79Qy6Wdf2/uOIUNe56A0Qc/dRb6/t6ELKz7A/hT/a0J5mZaDT28Q/SaK
 uE243V8rni1TP8R+S+s6HWC0qQBhgffqdSf1BeHh0jEn2Lbp9u0U/eLhhmmtem+CIltnk7msS
 QRwrTKpC7L/ontclCOCxbABz708USgh7V1mb4Zc/1ZWO8TlWN/RL8SM0X+onI/kMdg5BrxSth
 rFTtF/MWbc9v7A28evW0pemBWGWv22NInEUiwG0OqDshO8rvlMTaZ62o6Ft52qplKpMvXYVLq
 cc9ux5nBbLV09+/xfNJeqBrrSCswsKDCmpxACnPpjjenw=

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Did you take any of my review comments into account for this patch version so far?

Regards,
Markus

