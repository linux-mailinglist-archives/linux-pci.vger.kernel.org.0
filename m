Return-Path: <linux-pci+bounces-38874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE81BF6031
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 13:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2BE94E8640
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCC72EA75C;
	Tue, 21 Oct 2025 11:25:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E2264628
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045915; cv=none; b=QD/wUIPKsO29K4o4E0kLfGTZuPgXMm4dkuSZDFmoWbZv/NCSaNNb8LwO3IvhPZGeEqmmnmZYKD4wDdtMpgPzytHITe2lvhBr1SgkdxH5i+TRccb4OlNcLUx38+ZRJRrIR9MurxBlSwKAgGzFzZ9sFVeKoMDpL3ER8an5+pXD4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045915; c=relaxed/simple;
	bh=J+AP8QfB6tnmhyFQqZN8FZA7FoTImcEHiDiWzghQ48Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGs3dtfDfWpVwYOXrFEjVopglC19bSWOppdjFftw/WGQ4LhQ4wU+ws+vKJuYxMG/2EhonojQGxjjf2dZ2CEWKErXG092jV1YZI2qVd0jZsW9/QNJS5/q00Ca2VmClyf1rct46H2oxO+/Z9m2wBLlYAoTLKTJL2oS1+/zqvP2Do4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1761045875tfffd4087
X-QQ-Originating-IP: YCuuq5SdQASn49cjiByvT30NLCgx06xVpIRh9eZM3A8=
Received: from [IPV6:240f:10b:7440:1:fbdd:6094 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Oct 2025 19:24:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7541985687921448703
Message-ID: <3BA1DC4878E9DC7E+85e7ef2c-a762-4c12-8955-64212bc192da@radxa.com>
Date: Tue, 21 Oct 2025 20:24:31 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ROCK 5B/5B+ RTL8852BE probe failure on v6.18-rc
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
References: <7755D0222F97F8A4+6c855efa-561f-4fd9-aadd-a4de3d244c7e@radxa.com>
 <dgn3ekyon6jwfinerxx2ohpvebnxvuvpyqratfc3ciys4l4et7@5un6wskt4xn3>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <dgn3ekyon6jwfinerxx2ohpvebnxvuvpyqratfc3ciys4l4et7@5un6wskt4xn3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M5h5sZdLucAq4TyJ4gLxtJaWEb/noEow/YiyZ+tYKRtbuNU9Jkprjf+2
	awufwutNShCjo9zfXNG/up7hDhAzEmup11tx2PVw96rYj3u38MJ12CCTLpZWZPlt6C52hn5
	zA3tnqHQKNrKdOyWrPj+JjzBh8I0TDouBrU7ZSh394K/pSgRqR417BW9d8vXFliMjAkmFSu
	MtrKPAxDYlZSiAenMbxP1pYWVlMHVXoxJmZkBu4O1McVx9cyM8s96vE/1ecPnFUaX+qvwZL
	URENIQYqpOvVtY1buvQiXxbAApsSkN0Bn5FWaWdQipc/A3QxuhwXb+OujVFe6Zm0Evz7eMj
	326RD06OfpjZnbJ7QE++N2zKDPbtAJzS/3SgUgIRBDEfXsoOENZezQAWlNTrKNQoOh9+XhX
	Fl8qW1AZOx5tE/tMptxpa1fVE2ortR9/hUWyXwGs1mKmhemMwhfGEmfEMZZQhH0ay3GuDkp
	LZ6hQqe0KT53WtnlVYuPMuIghqUfOFSUOop/96SS4KgfsUIl4FjYRd2BDg6zYJkG6ZWU/51
	1HJKyEK4AEbHOvsPgMhfon7qqBMITGFfgfgs9x1RD2+K4XBouv7iHL5UEuNVfmguxLyMBJA
	gXkf8nPSn5bXw3lU9GEqjdKTJQdW47C7i6gPH9bXzRU2l/5jlHslsDKKrESryXI5C/eeFHP
	YyqYxYyS+IqksxSNH2zu2y4u8R4FB3iPQXM0ODZfW8IhxgIPeBEuw1qAVjj9ihfzWmPkAsy
	sb9c5DqfskwaBar9xi5HaKAEuJGNDJOh/4+TEfx06ry/799Xo2sFu/yx7TD0UKOqVwiBsxd
	o3w0sfyyXybXUN2g0GnsgloAsWEy+1vGAvszJtIXJgsKDfWHsem1D88jrdJw15z/0Ww6Bvv
	zV8D9sB9yQ8K5t9ohxq6CRAd7idI+7Clsb7vmnK48IXmUSYq8AbFdShSyp+FkJWn4AzGnml
	PSCjXQpx3QWRZAABmB343Mc1QpnMeaGuY+zyxBlAfNcPbvbH9gU+DTCABwpOCq7t2nhPiwz
	2frLi8AGuokwdFigAX
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-SPAM: true
X-QQ-RECHKSPAM: 3

Hi Manivannan,

Thank you for your reply.

On 10/21/25 20:02, Manivannan Sadhasivam wrote:
> On Tue, Oct 21, 2025 at 07:12:21PM +0900, FUKAUMI Naoki wrote:
>> Hi,
>>
>> I've observed an issue where the RTL8852BE fails to probe on the ROCK 5B and
>> ROCK 5B+ using Linux v6.18-rc.
>>
>> [    7.719288] rtw89_8852be 0002:21:00.0: loaded firmware
>> rtw89/rtw8852b_fw-1.bin
>> [    7.720192] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
>> [    7.728596] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5
>> (da87cccd), cmd version 0, type 5
>> [    7.729407] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5
>> (da87cccd), cmd version 0, type 3
>> [   11.420623] rtw89_8852be 0002:21:00.0: failed to dump efuse physical map
>> [   11.422859] rtw89_8852be 0002:21:00.0: failed to setup chip information
>> [   11.425273] rtw89_8852be 0002:21:00.0: probe with driver rtw89_8852be
>> failed with error -16
>>
>> This issue does not reproduce on v6.16. The issue does not reproduce with
>> the MT7921E or the AX210. Furthermore, the issue does not reproduce on the
>> ROCK 5A or the ROCK 5 ITX+.
>>
>> The issue appears not to reproduce in or prior to commit 14bed9bc81ba. The
>> issue reproduces, albeit with a low incidence rate, after commit
>> bf76f23aa1c1.
> 
> Both of these commits are merge commits and they seem to be not related to PCI
> or WiFi.
> 
>> It reproduces, but not 100%, on v6.17, and is likely 100%
>> reproducible on v6.18-rc.
>>
>> The dmesg output and the result of lspci -vv when the issue occurs can be
>> found below:
>>   https://gist.github.com/RadxaNaoki/bf57b6d3d88c1e4310a23247e7bac9de
>>
>> What should I investigate next?
>>
> 
> So the patch from Niklas [1] didn't solve the issue on these board + WiFi chip
> combo?

Yes, I am reproducing the issue with the patch applied, and it also 
reproduces on v6.17.

The RTL8852BE on the ROCK 5B+ is an onboard component, while the ROCK 5B 
uses an M.2 module; the issue does not appear on the ROCK 5A or ROCK 5 
ITX+ even with the same M.2 module and the same kernel/userland.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20251017163252.598812-2-cassel@kernel.org/
> 



